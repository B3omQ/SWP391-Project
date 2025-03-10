package controller.customer;

import dal.CustomerDAO;
import model.Customer;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 *
 * @author emkob
 */

public class MaturityScheduler {

    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    private final CustomerDAO customerDAO = new CustomerDAO();
    private final MaturityHandlerServlet maturityHandler = new MaturityHandlerServlet();

    public void startScheduler() {
         scheduler.scheduleAtFixedRate(this::processAllMaturedDeposits, 0, 1, TimeUnit.MINUTES);
    }

    private void processAllMaturedDeposits() {
        try {
            System.out.println("✅ Bắt đầu xử lý các khoản gửi tiết kiệm đáo hạn: " + java.time.LocalDateTime.now());
            List<Customer> customers = customerDAO.getAllCustomers(); // Lấy tất cả khách hàng
            for (Customer customer : customers) {
                maturityHandler.processMaturedDeposits(customer);
            }
            System.out.println("✅ Đã xử lý xong các khoản gửi tiết kiệm đáo hạn: " + java.time.LocalDateTime.now());
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