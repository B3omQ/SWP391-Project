package controller.customer;

import controller.customer.MaturityScheduler;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;

public class MaturitySchedulerListener implements ServletContextListener {

    private MaturityScheduler maturityScheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("✅ Ứng dụng khởi động: Bắt đầu scheduler xử lý đáo hạn tự động.");
        maturityScheduler = new MaturityScheduler();
        maturityScheduler.startScheduler();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("✅ Ứng dụng dừng: Tắt scheduler xử lý đáo hạn tự động.");
        if (maturityScheduler != null) {
            maturityScheduler.stopScheduler();
        }
    }
}