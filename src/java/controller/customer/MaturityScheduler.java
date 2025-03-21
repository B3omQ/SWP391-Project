package controller.customer;

import dal.CustomerDAO;
import model.Customer;
import java.math.BigDecimal;
import java.util.List;
import java.util.Set;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

public class MaturityScheduler {

    private final ScheduledExecutorService maturityScheduler = Executors.newScheduledThreadPool(1);
    private final ScheduledExecutorService autoProfitScheduler = Executors.newScheduledThreadPool(1);
    private final CustomerDAO customerDAO = new CustomerDAO();
    private final MaturityHandlerServlet maturityHandler = new MaturityHandlerServlet();

    public void startScheduler() {
        maturityScheduler.scheduleAtFixedRate(this::processMaturedDepositsForActiveCustomers, 0, 10, TimeUnit.SECONDS);
        autoProfitScheduler.scheduleAtFixedRate(this::processAutoProfitForAllCustomers, 0, 1, TimeUnit.DAYS);
    }

    /**
     * Xử lý đáo hạn chỉ cho khách hàng đang đăng nhập
     */
    private void processMaturedDepositsForActiveCustomers() {
        try {
            System.out.println(" Bắt đầu xử lý đáo hạn cho khách hàng đang đăng nhập: " + java.time.LocalDateTime.now());

            // Lấy danh sách ID khách hàng đang đăng nhập từ SessionTracker
            Set<Integer> activeCustomerIds = SessionTracker.getActiveCustomerIds();
            if (activeCustomerIds.isEmpty()) {
                System.out.println(" Không có khách hàng nào đang đăng nhập -> bỏ qua xử lý đáo hạn.");
                return;
            }

            // Lấy thông tin khách hàng từ cơ sở dữ liệu
            List<Customer> allCustomers = customerDAO.getAllCustomers();
            // Lọc chỉ những khách hàng đang đăng nhập
            List<Customer> activeCustomers = allCustomers.stream()
                .filter(customer -> activeCustomerIds.contains(customer.getId()))
                .collect(Collectors.toList());

            if (activeCustomers.isEmpty()) {
                System.out.println("Không tìm thấy khách hàng đang đăng nhập trong danh sách -> bỏ qua xử lý đáo hạn.");
                return;
            }

            // Xử lý đáo hạn cho từng khách hàng đang đăng nhập
            for (Customer customer : activeCustomers) {
                maturityHandler.processMaturedDeposits(customer);
                System.out.println(" Đã xử lý đáo hạn cho customer " + customer.getId());
            }

            System.out.println(" Hoàn tất xử lý đáo hạn: " + java.time.LocalDateTime.now());
        } catch (Exception e) {
            System.err.println(" Lỗi khi xử lý đáo hạn: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Xử lý sinh lời tự động cho tất cả khách hàng có bật tính năng này
     * (Giữ nguyên phần này vì bạn không yêu cầu thay đổi)
     */
    private void processAutoProfitForAllCustomers() {
        try {
            System.out.println("✅ Bắt đầu sinh lời tự động cho tất cả khách hàng: " + java.time.LocalDateTime.now());

            List<Customer> customers = customerDAO.getAllCustomers();
            for (Customer customer : customers) {
                if (customer.isAutoProfitEnabled()) {
                    processAutoProfit(customer);
                }
            }

            System.out.println(" Hoàn tất sinh lời tự động: " + java.time.LocalDateTime.now());
        } catch (Exception e) {
            System.err.println(" Lỗi khi sinh lời tự động: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Sinh lời tự động cho từng khách hàng bật tính năng này
     */
    private void processAutoProfit(Customer customer) {
        BigDecimal currentBalance = customer.getWallet();
        if (currentBalance.compareTo(BigDecimal.ZERO) > 0) {
            BigDecimal interestRate = new BigDecimal("0.0003"); // 0.03%/ngày
            BigDecimal interest = currentBalance.multiply(interestRate);
            BigDecimal newBalance = currentBalance.add(interest);

            boolean updated = customerDAO.updateWallet(customer.getId(), newBalance);
            if (updated) {
                System.out.println(" Sinh lời tự động cho customer " + customer.getId() + ": +" + interest + ", số dư mới: " + newBalance);
            } else {
                System.out.println(" Lỗi khi cập nhật sinh lời tự động cho customer " + customer.getId());
            }
        }
    }

    /**
     * Dừng scheduler khi cần
     */
    public void stopScheduler() {
        maturityScheduler.shutdown();
        autoProfitScheduler.shutdown();
        try {
            if (!maturityScheduler.awaitTermination(60, TimeUnit.SECONDS)) {
                maturityScheduler.shutdownNow();
            }
            if (!autoProfitScheduler.awaitTermination(60, TimeUnit.SECONDS)) {
                autoProfitScheduler.shutdownNow();
            }
        } catch (InterruptedException e) {
            maturityScheduler.shutdownNow();
            autoProfitScheduler.shutdownNow();
        }
    }
}