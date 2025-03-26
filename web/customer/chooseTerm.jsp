<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="container mt-5">
            <h2 class="text-center">Chọn Kỳ Hạn Gửi Tiết Kiệm</h2>
            <form id="termForm" action="${pageContext.request.contextPath}/Calculation" method="POST">
                <input type="hidden" name="selectedTerm" id="selectedTerm">
                <div class="row mt-4">
                    <c:if test="${not empty depServices}">
                        <c:forEach var="dep" items="${depServices}">
                            <div class="col-md-6 mb-3">
                                <div class="term-box" onclick="selectTerm(${dep.id})">
                                    <h4>${dep.depServiceName} (${dep.duringTime} tháng)</h4> <!-- Thêm tên gói -->
                                    <p>Lãi suất: <strong>${dep.savingRate}%/năm</strong></p>
                                    <c:if test="${not empty interestMap[dep.id]}">
                                        <p>Số tiền lãi ước tính: 
                                            <strong>
                                                <fmt:formatNumber value="${interestMap[dep.id]}" type="currency" currencySymbol="VND" groupingUsed="true"/>
                                            </strong>
                                        </p>
                                    </c:if>
                                    <c:if test="${not empty maturityDateMap[dep.id]}">
                                        <p>Ngày đáo hạn: <strong>${maturityDateMap[dep.id]}</strong></p>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-dark px-4 py-2" id="continueBtn" disabled>
                        Tiếp tục
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="template/footer.jsp" %>

<script>
    function selectTerm(id) {
        document.getElementById("selectedTerm").value = id;
        document.getElementById("continueBtn").disabled = false;
        console.log("Selected Term:", id);
    }

    document.getElementById("termForm").addEventListener("submit", function (event) {
        let selectedTerm = document.getElementById("selectedTerm").value;
        console.log("Submitting form with selectedTerm:", selectedTerm);

        if (!selectedTerm) {
            event.preventDefault(); // Chặn submit nếu chưa có giá trị
            alert("Vui lòng chọn kỳ hạn trước khi tiếp tục.");
        }
    });
</script>