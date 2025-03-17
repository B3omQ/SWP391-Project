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
        <form id="reviewForm" action="CustomerReview" method="post" class="mt-3">
            <div class="form-group">
                <label for="rate">Chọn mức độ hài lòng:</label>
                <div class="star-rating">
                    <input type="radio" id="star5" name="rate" value="5" required />
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
                <textarea name="review" id="review" class="form-control" rows="4" 
                    placeholder="Nhập nhận xét của bạn..." maxlength="500"></textarea>
                <small id="charCount" class="form-text text-muted">0/500 ký tự</small>
                <div id="reviewError" class="text-danger" style="display:none;"></div>
            </div>

            <button type="submit" class="btn btn-primary mt-3" id="submitBtn">Gửi đánh giá</button>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    const badWords = ['fuck', 'shit', 'damn', 'bitch'];

    // Character counter
    $('#review').on('input', function() {
        let length = $(this).val().length;
        $('#charCount').text(length + '/500 ký tự');
        
        if (length > 500) {
            $('#charCount').addClass('text-danger');
            $('#submitBtn').prop('disabled', true);
        } else {
            $('#charCount').removeClass('text-danger');
            $('#submitBtn').prop('disabled', false);
        }
    });

    $('#reviewForm').submit(function(e) {
        e.preventDefault();
        
        let reviewText = $('#review').val().toLowerCase();
        let rate = $('input[name="rate"]:checked').val();
        
        // Check for bad words
        let containsBadWords = badWords.some(word => 
            reviewText.includes(word)
        );
        
        if (containsBadWords) {
            $('#reviewError').text('Nhận xét chứa từ ngữ không phù hợp!').show();
            return;
        }
        
        if (reviewText.length > 500) {
            $('#reviewError').text('Nhận xét không được vượt quá 500 ký tự!').show();
            return;
        }
        
        if (!rate) {
            $('#reviewError').text('Vui lòng chọn mức độ hài lòng!').show();
            return;
        }
        
        // AJAX request
        $.ajax({
            url: 'CustomerReview',
            type: 'POST',
            data: {
                rate: rate,
                review: $('#review').val()
            },
            success: function(response) {
                alert('Đánh giá của bạn đã được gửi thành công!');
                $('#reviewForm')[0].reset();
                $('#charCount').text('0/500 ký tự');
                $('#reviewError').hide();
            },
            error: function(xhr, status, error) {
                let errorMsg = xhr.responseJSON?.error || 'Có lỗi xảy ra khi gửi đánh giá!';
                $('#reviewError').text(errorMsg).show();
            }
        });
    });
});
</script>

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
<%@ include file="template/footer.jsp" %>



