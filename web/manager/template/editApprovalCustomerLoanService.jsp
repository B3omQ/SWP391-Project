<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="customer-loan-service-management" method="post" id="editLoan-${param.id}">
    <div class="modal fade" id="editModal${param.id}" tabindex="-1" aria-labelledby="editModalLabel${param.id}" aria-hidden="true">
        <input name="updateId" type="hidden" value="${param.id}" />
        <div class="modal-dialog modal-xl">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="editModalLabel${param.id}">Thông tin chi tiết</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <!-- Modal Body -->
                <div class="modal-body bg-light">
                    <div class="row">
                        <!-- Profile Image -->
                        <div class="form-group text-center" style="display: flex">
                            <div class="col-md-6 mt-3 mb-3">
                                <label for="Customer Photo" class="col-form-label col-md-12">Ảnh đại diện</label>
                                <img src="${param.customerPhoto}" class="col-md-12 img-fluid rounded mt-3" alt="Customer Photo" style="max-width: 250px; height: 250px;">
                            </div>
                            <div class="col-md-6 mt-3 mb-3">
                                <label for="Income Verification" class="col-form-label col-md-12">Giấy chứng minh thu nhập</label>
                                <img src="${param.customerIncomeVertification}" class="col-md-12 img-fluid rounded mt-3" alt="Income Verification" style="max-width: 250px; height: 250px;">
                            </div>                            
                        </div>
                    </div>
                    <!-- Profile Details -->
                    <div class="row">
                        <div class="form-group row mt-3">
                            <label for="customerFullname" class="col-sm-4 col-form-label">Họ và tên khách hàng</label>
                            <div class="col-sm-8">
                                <input readonly="true" name="name" id="customerFullname" class="form-control" value="${param.customerFullname}">
                            </div>
                        </div>
                        <div class="form-group row mt-3">
                            <label for="customerEmail" class="col-sm-4 col-form-label">Email liên hệ</label>
                            <div class="col-sm-8">
                                <input readonly="true" name="email" id="customerEmail" class="form-control" value="${param.customerEmail}">
                            </div>
                        </div>
                        <div class="form-group row mt-3">
                            <label for="customerPhone" class="col-sm-4 col-form-label">Số điện thoại liên hệ</label>
                            <div class="col-sm-8">
                                <input readonly="true" name="phone" id="customerPhone" class="form-control" value="${param.customerPhone}">
                            </div>
                        </div>
                        <div class="form-group row mt-3">
                            <label for="customerDOB" class="col-sm-4 col-form-label">Ngày khai sinh</label>
                            <div class="col-sm-8">
                                <input readonly="true" name="dob" id="customerDOB" class="form-control" value="${param.customerDateOfBirth}">
                            </div>
                        </div>
                        <div class="form-group row mt-3">
                            <label for="customerAddress" class="col-sm-4 col-form-label">Địa chỉ khách hàng</label>
                            <div class="col-sm-8">
                                <input readonly="true" name="address" id="customerAddress" class="form-control" value="${param.customerAddress}">
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Modal Footer -->
                <div class="modal-footer">
                    <p id="error-message-${param.id}" class="text-warning me-auto"></p>
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                    <c:if test="${param.pendingStatus == 'Pending'}">
                        <button type="submit" name="status" value="Approved" class="btn btn-success">Approve</button>
                        <button type="submit" name="status" value="Denied" class="btn btn-danger">Deny</button>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</form>

<!-- Add some custom CSS -->
<style>
    .modal-header {
        background-color: #f8f9fa;
    }

    .form-group label {
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

    .img-fluid {
        max-width: 100%;
        height: auto;
    }
    .modal-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
</style>
