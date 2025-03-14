<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form style="display:inline-block" action="customer-admin-management" method="post" enctype="multipart/form-data" id="editCustomer-${param.id}">
    <div class="modal fade" id="editModal${param.id}" aria-labelledby="editModalLabel${param.id}" aria-hidden="true">
        <input name="updateId" type="hidden" value="${param.id}" />
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h1 class="modal-title fs-5" id="editModalLabel${param.id}">Update Customer</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <!-- Cột 1: Upload ảnh -->
                        <div class="col-md-5">
                            <div class="mb-3">
                                <label for="newImg" class="form-label">Ảnh (Max 5MB, jpg/png/gif)</label>
                                <input type="file" id="newImg" accept=".jpg,.png,.jpeg,.gif" name="newImg" class="form-control" onchange="previewImage(event, 'previewImg-${param.id}')">
                            </div>
                            <!-- Ảnh preview căn giữa, có viền và bo góc -->
                            <div class="d-flex justify-content-center">
                                <img id="previewImg-${param.id}" class="img-thumbnail shadow-sm" style="max-width: 250px; height: 250px; display: none; border: 2px solid #ccc;" alt="Preview Image">
                            </div>
                        </div>

                        <!-- Cột 2: Thông tin khách hàng -->
                        <div class="col-md-7">
                            <div class="mb-3">
                                <label for="newEmail" class="form-label">Email</label>
                                <input value="${param.email}" type="email" id="newEmail" name="newEmail" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="newFirstname" class="form-label">First Name</label>
                                <input value="${param.firstname}" type="text" id="newFirstname" name="newFirstname" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="newLastname" class="form-label">Last Name</label>
                                <input value="${param.lastname}" type="text" id="newLastname" name="newLastname" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="newPhone" class="form-label">Phone</label>
                                <input value="${param.phone}" type="text" id="newPhone" name="newPhone" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="newAddress" class="form-label">Address</label>
                                <input value="${param.address}" type="text" id="newAddress" name="newAddress" class="form-control" required>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="newDob" class="form-label">Date of Birth</label>
                                    <input type="date" id="newDob" name="newDob" value="${param.dob}" class="form-control">
                                </div>
                                <div class="col-md-6">
                                    <label for="newGender" class="form-label">Gender</label>
                                    <select id="newGender" name="newGender" class="form-control">
                                        <option value="Male" ${param.gender == 'Male' ? 'selected' : ''}>Male</option>
                                        <option value="Female" ${param.gender == 'Female' ? 'selected' : ''}>Female</option>
                                        <option value="Other" ${param.gender == 'Other' ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div> <!-- End row -->
                </div>

                <!-- Footer -->
                <div class="modal-footer">
                    <p id="error-message-${param.id}" class="text-danger"></p>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </div>
        </div>
    </div>    
</form>

<!-- Script xử lý preview ảnh -->
<script>
    function previewImage(event, previewId) {
        const input = event.target;
        const preview = document.getElementById(previewId);

        if (input.files && input.files[0]) {
            const file = input.files[0];

            // Kiểm tra kích thước ảnh (5MB = 5 * 1024 * 1024 bytes)
            if (file.size > 5 * 1024 * 1024) {
                alert("Ảnh quá lớn! Vui lòng chọn ảnh nhỏ hơn 5MB.");
                input.value = ""; // Reset input file
                return;
            }

            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = 'block';
            };
            reader.readAsDataURL(file);
        } else {
            preview.src = '#';
            preview.style.display = 'none';
        }
    }
</script>

<!-- Style CSS -->
<style>
    .modal-header {
        background-color: #007bff;
        color: white;
    }
    .form-label {
        font-weight: 600;
    }
    .form-control {
        padding: 10px;
        font-size: 14px;
    }
    .modal-body {
        font-size: 14px;
    }
    .img-thumbnail {
        border-radius: 10px;
        padding: 5px;
    }
    .btn-primary {
        background-color: #007bff;
        border: none;
    }
    .btn-primary:hover {
        background-color: #0056b3;
    }
</style>
