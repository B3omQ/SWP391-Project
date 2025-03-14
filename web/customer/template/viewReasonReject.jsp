<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl"> 
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="editModalLabel${param.id}">Thông tin định danh</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">

                <div class="form-group row text-center">
                    <div class="col-md-4">
                        <label class="col-form-label">Ảnh chân dung</label>
                        <div class="img-container">
                            <img src="${param.portraitPhoto}" class="img-thumbnail" alt="Ảnh chân dung">
                        </div>
                    </div>
                    <div class="form-group col-md-4">
                        <label class="col-form-label">Ảnh CCCD/CMND mặt trước</label>
                        <div class="img-container">
                            <img src="${param.identityCardFrontSide}" class="img-thumbnail" alt="CCCD mặt trước">
                        </div>
                    </div>
                    <div class="form-group col-md-4">
                        <label class="col-form-label">Ảnh CCCD/CMND mặt sau</label>
                        <div class="img-container">
                            <img src="${param.identityCardBackSide}" class="img-thumbnail" alt="CCCD mặt sau">
                        </div>
                    </div>
                </div>

                <div class="row mt-3">                    
                    <div class="form-group row">
                        <label for="identityCardnumber" class="col-sm-4 col-form-label">Số CCCD/CMND</label>
                        <div class="col-sm-8">
                            <input readonly name="email" id="identityCardnumber" class="form-control" value="${param.identityCardNumber}">
                        </div>
                    </div>
                </div>

                <div class="row">                    
                    <div class="form-group row mt-3">
                        <label for="reasonReject" class="col-sm-4 col-form-label">Lí do từ chối:</label>
                        <div class="col-sm-8">
                            <input readonly id="reasonReject" class="form-control" value="${param.reasonReject}">
                        </div>
                    </div>                    
                </div>
            </div>
            <!-- Modal Footer -->
            <div class="modal-footer">
                <p id="error-message-${param.id}" class="text-warning me-auto"></p>
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>                
            </div>
        </div>
    </div>
</div>


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
    }

    .modal-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
</style>
