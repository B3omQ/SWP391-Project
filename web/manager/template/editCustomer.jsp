<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form style="display:inline-block" action="customer-manager" method="post" enctype="multipart/form-data">
    <div class="modal fade" id="editModal${param.id}" tabindex="-1" aria-labelledby="editModalLabel${param.id}" aria-hidden="true">
        <input name="updateId" type="hidden" value="${param.id}" />
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="editModalLabel${param.id}">Update Customer</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label" for="newEmail">Email</label>
                            <input value="${param.email}" class="form-control" type="text" id="newEmail" name="newEmail">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <label for="newFirstname" class="form-label">First Name</label>
                            <input value="${param.firstname}" type="text" id="newFirstname" name="newFirstname" class="form-control">
                        </div>
                        <div class="col-md-4">
                            <label for="newLastname" class="form-label">Last Name</label>
                            <input value="${param.lastname}" type="text" id="newLastname" name="newLastname" class="form-control">
                        </div>
                        <div class="col-md-4">
                            <label for="newAddress" class="form-label">Address</label>
                            <input value="${param.address}" type="text" id="newAddress" name="newAddress" class="form-control">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <label for="newPhone" class="form-label">Phone</label>
                            <input value="${param.phone}" type="text" id="newPhone" name="newPhone" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <label for="newImg">Image</label>
                            <input type="file" id="newImg" name="newImg" class="form-control-file">
                        </div>
                    </div>

                    <!-- New fields for gender and date of birth -->
                    <div class="row">
                        <div class="col-md-6">
                            <label for="newGender" class="form-label">Gender</label>
                            <select id="newGender" name="newGender" class="form-control">
                                <option value="Male" ${param.gender == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${param.gender == 'Female' ? 'selected' : ''}>Female</option>
                                <option value="Other" ${param.gender == 'Other' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="newDob" class="form-label">Date of Birth</label>
                            <input type="date" id="newDob" name="newDob" value="${param.dob}" class="form-control">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>
            </div>
        </div>
    </div>    
</form>
