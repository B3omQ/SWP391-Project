<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>SmartBanking</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="<%= request.getContextPath() %>/assets/images/favicon.ico.png">
        <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .table {
                background: white;
                border-radius: 10px;
                overflow: hidden;
            }
            .table th, .table td {
                text-align: center;
                vertical-align: middle;
            }
            .photo {
                width: 80px;
                height: auto;
                border-radius: 5px;
                border: 1px solid #ddd;
            }
            .delete-icon {
                color: red;
                cursor: pointer;
            }
            .btn-info {
                color: white;
            }
            .modal-header {
                background-color: #dc3545;
                color: white;
            }
            .modal-footer .btn {
                background-color: #dc3545;
                color: white;
            }
        </style>
    </head>

    <body>
        <div class="container mt-5">
            <c:set value="${sessionScope.account}" var="customer" />
            <div class="card p-4 shadow-sm">
                <h3 class="text-center mb-4">Identity Verification</h3>
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Front Side</th>
                                <th>Back Side</th>
                                <th>Portrait</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="identity" items="${identityList}">
                                <tr>
                                    <td>${identity.id}</td>
                                    <td><img src="${identity.identityCardFrontSide}" class="photo"></td>
                                    <td><img src="${identity.identityCardBackSide}" class="photo"></td>
                                    <td><img src="${identity.portraitPhoto}" class="photo"></td>
                                    <td>
                                        <c:if test="${identity.pendingStatus != 'Approved'}">
                                            <i class="fas fa-trash delete-icon"></i>
                                        </c:if>
                                        <button type="button" class="btn btn-info ms-2" data-bs-toggle="modal" 
                                                data-bs-target="#detailsModal${identity.id}">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </td>
                                </tr>
                            <div class="modal fade" id="detailsModal${identity.id}" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Rejection Reason</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p class="text-center">${identity.reasonReject}</p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn" data-bs-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
