<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="identity-customer-management" method="post" id="editCustomer-${param.id}">
    <div class="modal fade" id="editModal${param.id}" tabindex="-1" aria-labelledby="editModalLabel${param.id}" aria-hidden="true">
        <input name="updateId" type="hidden" value="${param.id}" />
        <div class="modal-dialog modal-lg">
            <div class="modal-content rounded-3 shadow-lg border-0">

                <!-- Modal Header -->
                <div class="modal-header bg-danger text-white rounded-top-3">
                    <h5 class="modal-title" id="editModalLabel${param.id}">Customer Identity Verification</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <!-- Modal Body -->
                <div class="modal-body bg-light">
                    <div class="row">
                        <!-- Profile Image -->
                        <div class="col-md-4 text-center">                            
                            <p class="fw-semibold">Portrait Photo</p>
                            <img src="${param.portraitPhoto}" class="img-thumbnail mb-2" alt="Portrait Photo">
                        </div>
                        <!-- Profile Details -->
                        <div class="col-md-8">
                            <p><strong>Full Name:</strong> ${param.fullnameCustomer}</p>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <p class="mb-1 fw-semibold">Identity Card (Front)</p>
                                    <img src="${param.identityCardFrontSide}" class="img-fluid rounded border" style="max-height: 180px;" alt="Front Side">
                                </div>
                                <div class="col-md-6">
                                    <p class="mb-1 fw-semibold">Identity Card (Back)</p>
                                    <img src="${param.identityCardBackSide}" class="img-fluid rounded border" style="max-height: 180px;" alt="Back Side">
                                </div>
                            </div>
                            <c:if test="${not empty param.reasonReject}">
                                <div class="mt-3">
                                    <p class="text-danger fw-bold">Reason for Rejection:</p>
                                    <p class="text-danger">${param.reasonReject}</p>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <c:if test="${param.pendingStatus == 'Pending'}">
                        <div class="mt-3">
                            <label class="form-label fw-semibold" for="reasonReject">Reason reject (if denied):</label>
                            <textarea class="form-control" id="reasonReject" name="reasonReject" rows="3"></textarea>
                        </div>
                    </c:if>
                </div>

                <!-- Modal Footer -->
                <div class="modal-footer bg-danger text-white rounded-bottom-3">
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
