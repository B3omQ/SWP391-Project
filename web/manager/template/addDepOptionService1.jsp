<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="dep-option-service" method="post" id="addDepositeForm">
    <div class="modal fade" tabindex="-1" id="addDepositeModal" aria-labelledby="addDepositeModalLabel" aria-hidden="true">
        <input name ="add" value ="add" type="hidden"/>
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h1 class="modal-title fs-5" id="addDepositeModalLabel">Add New Deposite Option</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row mt-2">
                        <div class="col-md-6">
                            <label class="form-label head" for="minimumDep">Deposite Minimum</label>
                            <input class="form-control" type="number" id="minimumDep" name="minimumDep" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label head" for="duringTime">During Time (Months)</label>
                            <input class="form-control" type="number" id="duringTime" name="duringTime" required>
                        </div>
                    </div>                    
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <label class="form-label head" for="savingRate">Saving Rate (%)</label>
                            <input class="form-control" type="number" step="0.01" id="savingRate" name="savingRate" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label head" for="savingRateMinimum">Saving Rate Minimum (%)</label>
                            <input class="form-control" type="number" step="0.01" id="savingRateMinimum" name="savingRateMinimum" required>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <label class="form-label head" for="description">Description</label>
                            <textarea name ="description" id="description"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <p id="error-message" class="text-danger"></p>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Add Deposite Option</button>
                </div>
            </div>
        </div>
    </div>    
</form>




