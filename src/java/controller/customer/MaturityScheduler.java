package controller.customer;

import dal.CustomerDAO;
import model.Customer;
import java.time.LocalDateTime;
import java.util.Set;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class MaturityScheduler {

    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    private final CustomerDAO customerDAO = new CustomerDAO();
    private final MaturityHandlerServlet maturityHandler = new MaturityHandlerServlet();

    public void startScheduler() {
        // Chạy mỗi giờ một lần (có thể điều chỉnh tần suất)
        scheduler.scheduleAtFixedRate(this::processActiveUsersMaturedDeposits, 0, 1, TimeUnit.HOURS);
    }

    private void processActiveUsersMaturedDeposits() {
        try {
            System.out.println("✅ Bắt đầu xử lý các khoản gửi tiết kiệm đáo hạn cho người dùng đang đăng nhập: " + LocalDateTime.now());
            Set<Integer> activeCustomerIds = SessionTracker.getActiveCustomerIds();

            if (activeCustomerIds.isEmpty()) {
                System.out.println("⚠️ Không có người dùng nào đang đăng nhập.");
                return;
            }

            for (Integer customerId : activeCustomerIds) {
                Customer customer = customerDAO.getCustomerById(customerId);
                if (customer != null) {
                    maturityHandler.processMaturedDeposits(customer);
                }
            }
            System.out.println("✅ Đã xử lý xong các khoản gửi tiết kiệm đáo hạn cho " + activeCustomerIds.size() + " người dùng đang đăng nhập: " + LocalDateTime.now());
        } catch (Exception e) {
            System.err.println("❌ Lỗi khi xử lý đáo hạn tự động: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void stopScheduler() {
        scheduler.shutdown();
        try {
            if (!scheduler.awaitTermination(60, TimeUnit.SECONDS)) {
                scheduler.shutdownNow();
            }
        } catch (InterruptedException e) {
            scheduler.shutdownNow();
        }
    }
}