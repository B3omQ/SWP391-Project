<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="container mt-5">
            <div class="text-center">
                <h2><i class="fas fa-piggy-bank"></i> Tiền gửi có kỳ hạn</h2>
                <p>Giữ tiền an toàn, sinh lời hấp dẫn với lãi suất lên đến 5%/năm.</p>
            </div>
            <div class="row text-center mt-4">
                <div class="col-md-4">
                    <div class="feature-box">
                        <i class="fas fa-shield-alt icon-large"></i>
                        <p>An toàn và bảo mật tuyệt đối</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-box">
                        <i class="fas fa-percentage icon-large"></i>
                        <p>Nhận lãi suất đến 5%/năm</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-box">
                        <i class="fas fa-wallet icon-large"></i>
                        <p>Rút tiền linh hoạt theo nhu cầu</p>
                    </div>
                </div>
            </div>
            <div class="text-center mt-4">
                <button class="btn btn-dark px-4 py-2" onclick="startSaving()"><i class="fas fa-play"></i> Bắt đầu ngay</button>
            </div>
        </div>
    </div>
</div>

<%@ include file="template/footer.jsp" %>

<script>
    function startSaving() {
        window.location.href = 'savemoney.jsp';
    }
</script>