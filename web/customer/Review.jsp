<%-- 
    Document   : Review
    Created on : Mar 10, 2025, 3:43:19 PM
    Author     : LAPTOP
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="container-fluid mb-3">
    <h2 class="mt-3">Đánh giá dịch vụ</h2>
    <form action="CustomerReview" method="post" class="mt-3">
        <div class="form-group">
            <label for="rate">Chọn mức độ hài lòng:</label>
            <select name="rate" id="rate" class="form-control">
                <option value="5">5 - Tuyệt vời</option>
                <option value="4">4 - Tốt</option>
                <option value="3">3 - Bình thường</option>
                <option value="2">2 - Không hài lòng</option>
                <option value="1">1 - Rất tệ</option>
            </select>
        </div>

        <div class="form-group mt-2">
            <label for="review">Nhận xét của bạn:</label>
            <textarea name="review" id="review" class="form-control" rows="4" placeholder="Nhập nhận xét của bạn..."></textarea>
        </div>

        <button type="submit" class="btn btn-primary mt-3">Gửi đánh giá</button>
    </form>
</div>
    
</div>
<%@ include file="template/footer.jsp" %>



