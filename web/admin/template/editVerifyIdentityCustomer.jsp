<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="identity-customer-management" method="post" id="editCustomer-${param.id}">
    <div class="modal fade" id="editModal${param.id}" tabindex="-1" aria-labelledby="editModalLabel${param.id}" aria-hidden="true">
        <input name="updateId" type="hidden" value="${param.id}" />
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
    }

    .modal-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
</style>
