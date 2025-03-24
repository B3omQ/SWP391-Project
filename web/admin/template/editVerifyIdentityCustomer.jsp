<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="identity-customer-management" method="post" id="editCustomer-${param.id}">
    <div class="modal fade" id="editModal${param.id}" tabindex="-1" aria-labelledby="editModalLabel${param.id}" aria-hidden="true">
        <input name="updateId" type="hidden" value="${param.id}" />
        <input name="customerId" type="hidden" value="${param.customerId}" />
        <div class="modal-dialog modal-xl"> 
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="editModalLabel${param.id}">Thông tin định danh khách hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <!-- Modal Body -->
                <div class="modal-body">
                    <div class="form-group row text-center">
                        <div class="col-md-4">
                            <label class="col-form-label">Ảnh chân dung</label>
                            <div class="img-container">
                                <img id="zoomPortrait-${param.id}" src="${param.portraitPhoto}" class="img-thumbnail" alt="Ảnh chân dung" data-zoom-image="${param.portraitPhoto}">
                            </div>
                        </div>
                        <div class="form-group col-md-4">
                            <label class="col-form-label">Ảnh CCCD/CMND mặt trước</label>
                            <div class="img-container">
                                <img id="zoomFront-${param.id}" src="${param.identityCardFrontSide}" class="img-thumbnail" alt="CCCD mặt trước" data-zoom-image="${param.identityCardFrontSide}">
                            </div>
                        </div>
                        <div class="form-group col-md-4">
                            <label class="col-form-label">Ảnh CCCD/CMND mặt sau</label>
                            <div class="img-container">
                                <img id="zoomBack-${param.id}" src="${param.identityCardBackSide}" class="img-thumbnail" alt="CCCD mặt sau" data-zoom-image="${param.identityCardBackSide}">
                            </div>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="form-group row mt-3">
                            <label for="fullnameCustomer" class="col-sm-4 col-form-label">Họ và tên khách hàng</label>
                            <div class="col-sm-8">
                                <input readonly name="name" id="fullnameCustomer" class="form-control" value="${param.fullnameCustomer}">
                            </div>
                        </div>
                        <div class="form-group row mt-3">
                            <label for="identityCardnumber" class="col-sm-4 col-form-label">Số CCCD/CMND</label>
                            <div class="col-sm-8">
                                <input readonly name="email" id="identityCardnumber" class="form-control" value="${param.identityCardNumber}">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <c:if test="${param.pendingStatus == 'Denied'}">
                            <div class="form-group row mt-3">
                                <label for="reasonReject" class="col-sm-4 col-form-label">Lí do từ chối (nếu có):</label>
                                <div class="col-sm-8">
                                    <input readonly id="reasonReject" class="form-control" value="${param.reasonReject}">
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <div class="row">
                        <c:if test="${param.pendingStatus == 'Pending'}">
                            <div class="form-group row mt-3">
                                <label for="reasonReject" class="col-sm-4 col-form-label">Lí do từ chối (nếu có):</label>
                                <div class="col-sm-8">
                                    <textarea class="form-control" id="reasonReject" name="reasonReject" placeholder="Lí do..."></textarea>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Modal Footer -->
                <div class="modal-footer">
                    <p id="error-message-${param.id}" class="text-warning me-auto"></p>
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>
                    <c:if test="${param.pendingStatus == 'Pending'}">
                        <button type="submit" name="status" value="Approved" class="btn btn-success">Chấp nhận</button>
                        <button type="submit" name="status" value="Denied" class="btn btn-danger">Từ chối</button>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</form>

<style>
    .modal-header {
        background-color: #f8f9fa;
    }

    .form-group label {
        font-weight: 600;
        font-size: 15px;
    }

    .form-label {
        font-weight: 600;
        font-size: 15px;
    }

    .form-control {
        font-size: 14px;
        padding: 10px;
    }

    .modal-body {
        font-size: 14px;
    }

    /* Cố định kích thước ảnh để tất cả ảnh có cùng tỷ lệ */
    .img-container {
        width: 100%;
        height: 300px;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
    }

    .img-thumbnail {
        width: 100%;
        height: 100%;
        object-fit: cover;
        cursor: zoom-in;
    }

    .modal-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    /* Tăng z-index cho phần tử zoom của ElevateZoom */
    .zoomContainer {
        z-index: 1070 !important; /* Cao hơn z-index của modal (1060) */
    }

    /* Đảm bảo lens không bị che khuất */
    .zoomLens {
        z-index: 1071 !important;
    }
</style>

<script>

    $(document).ready(function () {
        $('#editModal${param.id}').on('shown.bs.modal', function () {
            $("#zoomPortrait-${param.id}").elevateZoom({
                zoomType: "lens", // Hiệu ứng phóng to kiểu lens
                lensShape: "round", // Hình dạng lens là tròn
                lensSize: 300, // Kích thước lens
                scrollZoom: true, 
                zoomWindowWidth: 400, // Chiều rộng cửa sổ zoom
                zoomWindowHeight: 400, // Chiều cao cửa sổ zoom
                borderSize: 1, // Độ dày viền
                borderColour: "#888"        // Màu viền
            });

            $("#zoomFront-${param.id}").elevateZoom({
                zoomType: "lens",
                lensShape: "round",
                lensSize: 300,
                scrollZoom: true,
                zoomWindowWidth: 400,
                zoomWindowHeight: 400,
                borderSize: 1,
                borderColour: "#888"
            });

            $("#zoomBack-${param.id}").elevateZoom({
                zoomType: "lens",
                lensShape: "round",
                lensSize: 300,
                scrollZoom: true,
                zoomWindowWidth: 400,
                zoomWindowHeight: 400,
                borderSize: 1,
                borderColour: "#888"
            });
        });

        // Khi modal đóng, xóa ElevateZoom để tránh lỗi
        $('#editModal${param.id}').on('hidden.bs.modal', function () {
            $.removeData($('#zoomPortrait-${param.id}'), 'elevateZoom');
            $.removeData($('#zoomFront-${param.id}'), 'elevateZoom');
            $.removeData($('#zoomBack-${param.id}'), 'elevateZoom');
            $('.zoomContainer').remove(); // Xóa container zoom khỏi DOM
        });
    });
</script>