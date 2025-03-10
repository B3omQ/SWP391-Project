/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package dal;

import java.util.List;
import model.LoanServiceUsed;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author JIGGER
 */
public class LoanServiceUsedDAOTest {
    
    public LoanServiceUsedDAOTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of getLoanServiceUsedByStatus method, of class LoanServiceUsedDAO.
     */
    @Test
    public void testGetLoanServiceUsedByStatus() {
        System.out.println("getLoanServiceUsedByStatus");
        int offset = 0;
        int recordsPerPage = 10;
        String status = "Pending";
        LoanServiceUsedDAO instance = new LoanServiceUsedDAO();
        List<LoanServiceUsed> expResult = null;
        List<LoanServiceUsed> result = instance.getLoanServiceUsedByStatus(offset, recordsPerPage, status);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        
    }

}
