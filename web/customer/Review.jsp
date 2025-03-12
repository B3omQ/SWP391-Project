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
<style>
    .star-rating {
        display: flex;
        flex-direction: row-reverse;
        justify-content: start;
    }
    .star-rating input {
        display: none;
    }
    .star-rating label {
        font-size: 2rem;
        color: gray;
        cursor: pointer;
    }
    .star-rating label:hover,
    .star-rating label:hover ~ label,
    .star-rating input:checked ~ label {
        color: gold;
    }
</style>

<div class="container-fluid">
    <div class="container-fluid mb-3">
    <h2 class="mt-3">Đánh giá dịch vụ</h2>
    <form action="CustomerReview" method="post" class="mt-3">
    <div class="form-group">
        <label for="rate">Chọn mức độ hài lòng:</label>
        <div class="star-rating">
            <input type="radio" id="star5" name="rate" value="5" />
            <label for="star5" class="mdi mdi-star"></label>
            
            <input type="radio" id="star4" name="rate" value="4" />
            <label for="star4" class="mdi mdi-star"></label>
            
            <input type="radio" id="star3" name="rate" value="3" />
            <label for="star3" class="mdi mdi-star"></label>
            
            <input type="radio" id="star2" name="rate" value="2" />
            <label for="star2" class="mdi mdi-star"></label>
            
            <input type="radio" id="star1" name="rate" value="1" />
            <label for="star1" class="mdi mdi-star"></label>
        </div>
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



