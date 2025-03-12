package controller.customer;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import model.Customer;
import java.util.HashSet;
import java.util.Set;

public class SessionTracker implements HttpSessionListener {

    private static final Set<Integer> activeCustomerIds = new HashSet<>();

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        Customer customer = (Customer) session.getAttribute("account");
        if (customer != null) {
            synchronized (activeCustomerIds) {
                activeCustomerIds.add(customer.getId());
                System.out.println("✅ Customer " + customer.getId() + " logged in. Active users: " + activeCustomerIds.size());
            }
        }
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        Customer customer = (Customer) session.getAttribute("account");
        if (customer != null) {
            synchronized (activeCustomerIds) {
                activeCustomerIds.remove(customer.getId());
                System.out.println("✅ Customer " + customer.getId() + " logged out. Active users: " + activeCustomerIds.size());
            }
        }
    }

    public static Set<Integer> getActiveCustomerIds() {
        synchronized (activeCustomerIds) {
            return new HashSet<>(activeCustomerIds); 
        }
    }
}