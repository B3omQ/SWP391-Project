<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form style="display:inline-block" action="customer-admin-management" method="post" enctype="multipart/form-data" id="editCustomer-${param.id}">
    <div class="modal fade" tabindex="-1" id="editModal${param.id}" aria-labelledby="editModalLabel${param.id}" aria-hidden="true">
        <input name="updateId" type="hidden" value="${param.id}" />
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h1 class="modal-title fs-5" id="editModalLabel${param.id}">Update Customer</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row mt-2">
                        <div class="col-md-6">
                            <label class="form-label head" for="newEmail">Email</label>
                            <input value="${param.email}" class="form-control" type="email" id="newEmail" name="newEmail" required>
                        </div>
                        <div class="col-md-6" style="margin-top : 35px">
                            <label for="newImg" class ="head">Image</label>
                            <input type="file" id="newImg" accept=".jpg,.png,.jpeg,.gif" name="newImg" class="form-control-file">
                        </div>
                    </div>                    
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <label for="newFirstname" class="form-label head">First Name</label>
                            <input value="${param.firstname}" type="text" id="newFirstname" name="newFirstname" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label for="newLastname" class="form-label head">Last Name</label>
                            <input value="${param.lastname}" type="text" id="newLastname" name="newLastname" class="form-control" required>
                        </div>
                    </div>                        
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <label for="newPhone" class="form-label head">Phone</label>
                            <input value="${param.phone}" type="text" id="newPhone" name="newPhone" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label for="newAddress" class="form-label head">Address</label>
                            <input value="${param.address}" type="text" id="newAddress" name="newAddress" class="form-control" required>
                        </div>
                    </div>                    

                    <!-- New fields for gender and date of birth -->
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <label for="newGender" class="form-label head">Gender</label>
                            <select id="newGender" name="newGender" class="form-control">
                                <option value="Male" ${param.gender == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${param.gender == 'Female' ? 'selected' : ''}>Female</option>
                                <option value="Other" ${param.gender == 'Other' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="newDob" class="form-label head">Date of Birth</label>
                            <input type="date" id="newDob" name="newDob" value="${param.dob}" class="form-control">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <p id="error-message-${param.id}" class="text-danger"></p>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>
            </div>
        </div>
    </div>    
</form>

