<%-- 
    Document   : profileConsultant
    Created on : Feb 10, 2025, 4:49:49 PM
    Author     : LAPTOP
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <!-- DataTables CSS & jQuery -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <head>
        <meta charset="utf-8" />
        <title>SmartBanking</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="../../../index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="<%= request.getContextPath() %>/assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="<%= request.getContextPath() %>/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="<%= request.getContextPath() %>/assets/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/flatpickr.min.css">
        <link href="<%= request.getContextPath() %>/assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="<%= request.getContextPath() %>/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- Css -->
        <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <!--         DataTables CSS & jQuery 
                <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>-->

    </head>

    <body>
        <!-- Loader -->
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>
        <!-- Loader -->
        <nav id="sidebar" class="sidebar-wrapper">
            <jsp:include page="template/sidebar.jsp"/>
            <!-- sidebar-content  -->
            <ul class="sidebar-footer list-unstyled mb-0">
                <li class="list-inline-item mb-0 ms-1">
                    <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                        <i class="uil uil-comment icons"></i>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- sidebar-wrapper  -->

        <!-- Start Page Content -->
        <main class="page-content bg-light">
            <jsp:include page="template/header.jsp"/>
            <div class="container-fluid">
                <div class="layout-specing">
                    <div class="d-md-flex justify-content-between">
                        <h5 class="mb-0">Doctor Profile & Settings</h5>

                        <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                            <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                <li class="breadcrumb-item"><a href="index.html">Doctris</a></li>
                                <li class="breadcrumb-item"><a href="doctors.html">Doctor</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Profile</li>
                            </ul>
                        </nav>
                    </div>

                    <div class="card bg-white rounded shadow overflow-hidden mt-4 border-0">
                        <div class="p-5 bg-primary bg-gradient"></div>
                        <div class="avatar-profile d-flex margin-nagative mt-n5 position-relative ps-3">
                            <img src="../assets/images/doctors/01.jpg"
                                 class="rounded-circle shadow-md avatar avatar-medium" alt="">
                            <div class="mt-4 ms-3 pt-3">
                                <h5 class="mt-3 mb-1">Dr. Calvin Carlo</h5>
                                <p class="text-muted mb-0">Orthopedic</p>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="card border-0 rounded-0 p-4">
                                    <ul class="nav nav-pills nav-justified flex-column flex-sm-row rounded shadow overflow-hidden bg-light"
                                        id="pills-tab" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link rounded-0 active" id="overview-tab" data-bs-toggle="pill"
                                               href="#pills-overview" role="tab" aria-controls="pills-overview"
                                               aria-selected="false">
                                                <div class="text-center pt-1 pb-1">
                                                    <h4 class="title fw-normal mb-0">Overview</h4>
                                                </div>
                                            </a><!--end nav link-->
                                        </li><!--end nav item-->

                                        <li class="nav-item">
                                            <a class="nav-link rounded-0" id="experience-tab" data-bs-toggle="pill"
                                               href="#pills-experience" role="tab" aria-controls="pills-experience"
                                               aria-selected="false">
                                                <div class="text-center pt-1 pb-1">
                                                    <h4 class="title fw-normal mb-0">Experience</h4>
                                                </div>
                                            </a><!--end nav link-->
                                        </li><!--end nav item-->

                                        <li class="nav-item">
                                            <a class="nav-link rounded-0" id="review-tab" data-bs-toggle="pill"
                                               href="#pills-review" role="tab" aria-controls="pills-review"
                                               aria-selected="false">
                                                <div class="text-center pt-1 pb-1">
                                                    <h4 class="title fw-normal mb-0">Reviews</h4>
                                                </div>
                                            </a><!--end nav link-->
                                        </li><!--end nav item-->

                                        <li class="nav-item">
                                            <a class="nav-link rounded-0" id="timetable-tab" data-bs-toggle="pill"
                                               href="#pills-timetable" role="tab" aria-controls="pills-timetable"
                                               aria-selected="false">
                                                <div class="text-center pt-1 pb-1">
                                                    <h4 class="title fw-normal mb-0">Time Table</h4>
                                                </div>
                                            </a><!--end nav link-->
                                        </li><!--end nav item-->

                                        <li class="nav-item">
                                            <a class="nav-link rounded-0" id="settings-tab" data-bs-toggle="pill"
                                               href="#pills-settings" role="tab" aria-controls="pills-settings"
                                               aria-selected="false">
                                                <div class="text-center pt-1 pb-1">
                                                    <h4 class="title fw-normal mb-0">Settings</h4>
                                                </div>
                                            </a><!--end nav link-->
                                        </li><!--end nav item-->
                                    </ul><!--end nav pills-->

                                    <div class="tab-content mt-2" id="pills-tabContent">
                                        <div class="tab-pane fade show active" id="pills-overview" role="tabpanel"
                                             aria-labelledby="overview-tab">
                                            <p class="text-muted">A gynecologist is a surgeon who specializes in the
                                                female reproductive system, which includes the cervix, fallopian tubes,
                                                ovaries, uterus, vagina and vulva. Menstrual problems, contraception,
                                                sexuality, menopause and infertility issues are diagnosed and treated by
                                                a gynecologist; most gynecologists also provide prenatal care, and some
                                                provide primary care.</p>

                                            <h6 class="mb-0">Specialties: </h6>

                                            <ul class="list-unstyled mt-4">
                                                <li class="mt-1"><i class="uil uil-arrow-right text-primary"></i>
                                                    Women's health services</li>
                                                <li class="mt-1"><i class="uil uil-arrow-right text-primary"></i>
                                                    Pregnancy care</li>
                                                <li class="mt-1"><i class="uil uil-arrow-right text-primary"></i>
                                                    Surgical procedures</li>
                                                <li class="mt-1"><i class="uil uil-arrow-right text-primary"></i>
                                                    Specialty care</li>
                                                <li class="mt-1"><i class="uil uil-arrow-right text-primary"></i>
                                                    Conclusion</li>
                                            </ul>
                                        </div><!--end teb pane-->

                                        <div class="tab-pane fade" id="pills-experience" role="tabpanel"
                                             aria-labelledby="experience-tab">
                                            <h5 class="mb-1">Experience:</h5>

                                            <p class="text-muted mt-4">The most well-known dummy text is the 'Lorem
                                                Ipsum', which is said to have originated in the 16th century. Lorem
                                                Ipsum is composed in a pseudo-Latin language which more or less
                                                corresponds to 'proper' Latin. It contains a series of real Latin words.
                                                This ancient dummy text is also incomprehensible, but it imitates the
                                                rhythm of most European languages in Latin script. The advantage of its
                                                Latin origin and the relative meaninglessness of Lorum Ipsum is that the
                                                text does not attract attention to itself or distract the viewer's
                                                attention from the layout.</p>

                                            <h6 class="mb-0">Professional Experience:</h6>

                                            <div class="row">
                                                <div class="col-12 mt-4">
                                                    <div class="col-md-12">
                                                        <div class="slider-range-four tiny-timeline">
                                                            <div class="tiny-slide text-center">
                                                                <div
                                                                    class="card border-0 p-4 item-box mb-2 shadow rounded">
                                                                    <p class="text-muted mb-0">2010 - 2014</p>
                                                                    <h6 class="mt-1">Master Of Science</h6>
                                                                    <p class="text-muted mb-0">X.Y.Z Hospital (NZ)</p>
                                                                </div>
                                                            </div>

                                                            <div class="tiny-slide text-center">
                                                                <div
                                                                    class="card border-0 p-4 item-box mb-2 shadow rounded">
                                                                    <p class="text-muted mb-0">2014 - 2016</p>
                                                                    <h6 class="mt-1">Gynecology Test</h6>
                                                                    <p class="text-muted mb-0">X.Y.Z Hospital (NZ)</p>
                                                                </div>
                                                            </div>

                                                            <div class="tiny-slide text-center">
                                                                <div
                                                                    class="card border-0 p-4 item-box mb-2 shadow rounded">
                                                                    <p class="text-muted mb-0">2016 - 2019</p>
                                                                    <h6 class="mt-1">Master Of Medicine</h6>
                                                                    <p class="text-muted mb-0">X.Y.Z Hospital (NZ)</p>
                                                                </div>
                                                            </div>

                                                            <div class="tiny-slide text-center">
                                                                <div
                                                                    class="card border-0 p-4 item-box mb-2 shadow rounded">
                                                                    <p class="text-muted mb-0">2019 - 2020</p>
                                                                    <h6 class="mt-1">Orthopedics</h6>
                                                                    <p class="text-muted mb-0">X.Y.Z Hospital (NZ)</p>
                                                                </div>
                                                            </div>

                                                            <div class="tiny-slide text-center">
                                                                <div
                                                                    class="card border-0 p-4 item-box mb-2 shadow rounded">
                                                                    <p class="text-muted mb-0">2020 to continue..</p>
                                                                    <h6 class="mt-1">Gynecologist (Final)</h6>
                                                                    <p class="text-muted mb-0">X.Y.Z Hospital (NZ)</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div><!--end col-->
                                            </div><!--end row-->
                                        </div><!--end teb pane-->

                                        <div class="tab-pane fade" id="pills-review" role="tabpanel"
                                             aria-labelledby="review-tab">
                                            <div class="row justify-content-center">
                                                <div class="col-lg-8 text-center">
                                                    <div class="client-review-slider">
                                                        <div class="tiny-slide text-center">
                                                            <p class="text-muted h6 fw-normal fst-italic">" It seems
                                                                that only fragments of the original text remain in the
                                                                Lorem Ipsum texts used today. The most well-known dummy
                                                                text is the 'Lorem Ipsum', which is said to have
                                                                originated in the 16th century. "</p>
                                                            <img src="../assets/images/client/01.jpg"
                                                                 class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3"
                                                                 alt="">
                                                            <ul class="list-unstyled mb-0">
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                            </ul>
                                                            <h6 class="text-primary">- Thomas Israel <small
                                                                    class="text-muted">C.E.O</small></h6>
                                                        </div><!--end customer testi-->

                                                        <div class="tiny-slide text-center">
                                                            <p class="text-muted h6 fw-normal fst-italic">" The
                                                                advantage of its Latin origin and the relative
                                                                meaninglessness of Lorum Ipsum is that the text does not
                                                                attract attention to itself or distract the viewer's
                                                                attention from the layout. "</p>
                                                            <img src="../assets/images/client/02.jpg"
                                                                 class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3"
                                                                 alt="">
                                                            <ul class="list-unstyled mb-0">
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                            </ul>
                                                            <h6 class="text-primary">- Carl Oliver <small
                                                                    class="text-muted">P.A</small></h6>
                                                        </div><!--end customer testi-->

                                                        <div class="tiny-slide text-center">
                                                            <p class="text-muted h6 fw-normal fst-italic">" There is now
                                                                an abundance of readable dummy texts. These are usually
                                                                used when a text is required purely to fill a space.
                                                                These alternatives to the classic Lorem Ipsum texts are
                                                                often amusing and tell short, funny or nonsensical
                                                                stories. "</p>
                                                            <img src="../assets/images/client/03.jpg"
                                                                 class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3"
                                                                 alt="">
                                                            <ul class="list-unstyled mb-0">
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                            </ul>
                                                            <h6 class="text-primary">- Barbara McIntosh <small
                                                                    class="text-muted">M.D</small></h6>
                                                        </div><!--end customer testi-->

                                                        <div class="tiny-slide text-center">
                                                            <p class="text-muted h6 fw-normal fst-italic">" According to
                                                                most sources, Lorum Ipsum can be traced back to a text
                                                                composed by Cicero in 45 BC. Allegedly, a Latin scholar
                                                                established the origin of the text by compiling all the
                                                                instances of the unusual word 'consectetur' he could
                                                                find "</p>
                                                            <img src="../assets/images/client/04.jpg"
                                                                 class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3"
                                                                 alt="">
                                                            <ul class="list-unstyled mb-0">
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                            </ul>
                                                            <h6 class="text-primary">- Christa Smith <small
                                                                    class="text-muted">Manager</small></h6>
                                                        </div><!--end customer testi-->

                                                        <div class="tiny-slide text-center">
                                                            <p class="text-muted h6 fw-normal fst-italic">" It seems
                                                                that only fragments of the original text remain in the
                                                                Lorem Ipsum texts used today. The most well-known dummy
                                                                text is the 'Lorem Ipsum', which is said to have
                                                                originated in the 16th century. "</p>
                                                            <img src="../assets/images/client/05.jpg"
                                                                 class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3"
                                                                 alt="">
                                                            <ul class="list-unstyled mb-0">
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                            </ul>
                                                            <h6 class="text-primary">- Dean Tolle <small
                                                                    class="text-muted">Developer</small></h6>
                                                        </div><!--end customer testi-->

                                                        <div class="tiny-slide text-center">
                                                            <p class="text-muted h6 fw-normal fst-italic">" It seems
                                                                that only fragments of the original text remain in the
                                                                Lorem Ipsum texts used today. One may speculate that
                                                                over the course of time certain letters were added or
                                                                deleted at various positions within the text. "</p>
                                                            <img src="../assets/images/client/06.jpg"
                                                                 class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3"
                                                                 alt="">
                                                            <ul class="list-unstyled mb-0">
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                                <li class="list-inline-item"><i
                                                                        class="mdi mdi-star text-warning"></i></li>
                                                            </ul>
                                                            <h6 class="text-primary">- Jill Webb <small
                                                                    class="text-muted">Designer</small></h6>
                                                        </div><!--end customer testi-->
                                                    </div><!--end carousel-->
                                                </div><!--end col-->
                                            </div><!--end row-->

                                            <div class="row justify-content-center">
                                                <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                                                    <img src="../assets/images/client/amazon.png"
                                                         class="avatar avatar-client" alt="">
                                                </div><!--end col-->

                                                <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                                                    <img src="../assets/images/client/google.png"
                                                         class="avatar avatar-client" alt="">
                                                </div><!--end col-->

                                                <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                                                    <img src="../assets/images/client/lenovo.png"
                                                         class="avatar avatar-client" alt="">
                                                </div><!--end col-->

                                                <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                                                    <img src="../assets/images/client/paypal.png"
                                                         class="avatar avatar-client" alt="">
                                                </div><!--end col-->

                                                <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                                                    <img src="../assets/images/client/shopify.png"
                                                         class="avatar avatar-client" alt="">
                                                </div><!--end col-->

                                                <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                                                    <img src="../assets/images/client/spotify.png"
                                                         class="avatar avatar-client" alt="">
                                                </div><!--end col-->
                                            </div><!--end row-->
                                        </div><!--end teb pane-->

                                        <div class="tab-pane fade" id="pills-timetable" role="tabpanel"
                                             aria-labelledby="timetable-tab">
                                            <div class="row">
                                                <div class="col-lg-4 col-md-12">
                                                    <div class="card border-0 p-3 rounded shadow">
                                                        <ul class="list-unstyled mb-0">
                                                            <li class="d-flex justify-content-between">
                                                                <p class="text-muted mb-0"><i
                                                                        class="ri-time-fill text-primary align-middle h5 mb-0"></i>
                                                                    Monday</p>
                                                                <p class="text-primary mb-0"><span
                                                                        class="text-dark">Time:</span> 8.00 - 20.00</p>
                                                            </li>
                                                            <li class="d-flex justify-content-between mt-2">
                                                                <p class="text-muted mb-0"><i
                                                                        class="ri-time-fill text-primary align-middle h5 mb-0"></i>
                                                                    Tuesday</p>
                                                                <p class="text-primary mb-0"><span
                                                                        class="text-dark">Time:</span> 8.00 - 20.00</p>
                                                            </li>
                                                            <li class="d-flex justify-content-between mt-2">
                                                                <p class="text-muted mb-0"><i
                                                                        class="ri-time-fill text-primary align-middle h5 mb-0"></i>
                                                                    Wednesday</p>
                                                                <p class="text-primary mb-0"><span
                                                                        class="text-dark">Time:</span> 8.00 - 20.00</p>
                                                            </li>
                                                            <li class="d-flex justify-content-between mt-2">
                                                                <p class="text-muted mb-0"><i
                                                                        class="ri-time-fill text-primary align-middle h5 mb-0"></i>
                                                                    Thursday</p>
                                                                <p class="text-primary mb-0"><span
                                                                        class="text-dark">Time:</span> 8.00 - 20.00</p>
                                                            </li>
                                                            <li class="d-flex justify-content-between mt-2">
                                                                <p class="text-muted mb-0"><i
                                                                        class="ri-time-fill text-primary align-middle h5 mb-0"></i>
                                                                    Friday</p>
                                                                <p class="text-primary mb-0"><span
                                                                        class="text-dark">Time:</span> 8.00 - 20.00</p>
                                                            </li>
                                                            <li class="d-flex justify-content-between mt-2">
                                                                <p class="text-muted mb-0"><i
                                                                        class="ri-time-fill text-primary align-middle h5 mb-0"></i>
                                                                    Saturday</p>
                                                                <p class="text-primary mb-0"><span
                                                                        class="text-dark">Time:</span> 8.00 - 18.00</p>
                                                            </li>
                                                            <li class="d-flex justify-content-between mt-2">
                                                                <p class="text-muted mb-0"><i
                                                                        class="ri-time-fill text-primary align-middle h5 mb-0"></i>
                                                                    Sunday</p>
                                                                <p class="text-primary mb-0"><span
                                                                        class="text-dark">Time:</span> 8.00 - 14.00</p>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="col-lg-4 col-md-6 mt-4 mt-lg-0 pt-2 pt-lg-0">
                                                    <div class="card border-0 text-center features feature-primary">
                                                        <div class="icon text-center mx-auto rounded-md">
                                                            <i class="uil uil-phone h3 mb-0"></i>
                                                        </div>

                                                        <div class="card-body p-0 mt-4">
                                                            <h5 class="title fw-bold">Phone</h5>
                                                            <p class="text-muted">Great doctor if you need your family
                                                                member to get effective immediate assistance</p>
                                                            <a href="tel:+152534-468-854" class="link">+152
                                                                534-468-854</a>
                                                        </div>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="col-lg-4 col-md-6 mt-4 mt-lg-0 pt-2 pt-lg-0">
                                                    <div class="card border-0 text-center features feature-primary">
                                                        <div class="icon text-center mx-auto rounded-md">
                                                            <i class="uil uil-envelope h3 mb-0"></i>
                                                        </div>

                                                        <div class="card-body p-0 mt-4">
                                                            <h5 class="title fw-bold">Email</h5>
                                                            <p class="text-muted">Great doctor if you need your family
                                                                member to get effective immediate assistance</p>
                                                            <a href="mailto:contact@example.com"
                                                               class="link">contact@example.com</a>
                                                        </div>
                                                    </div>
                                                </div><!--end col-->
                                            </div><!--end row-->
                                        </div><!--end teb pane-->

                                        <div class="tab-pane fade" id="pills-settings" role="tabpanel"
                                             aria-labelledby="settings-tab">
                                            <h5 class="mb-1">Settings</h5>
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="rounded shadow mt-4">
                                                        <div class="p-4 border-bottom">
                                                            <strong class="mb-0">Thông tin cá nhân :</strong>
                                                        </div>
                                                        <div class="p-4">
                                                            <div class="row align-items-center">
                                                                <div class="col-lg-2 col-md-4">
                                                                    <img src="${staff.image}"
                                                                         class="avatar avatar-md-md rounded-pill shadow mx-auto d-block"
                                                                         alt="Image" accept=".jpg,.png">
                                                                </div><!--end col-->
                                                                <div
                                                                    class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                                                    <h6 class="">Upload your picture</h6>
                                                                    <p class="text-muted mb-0">For best results, use an
                                                                        image at least 256px by 256px in either .jpg or
                                                                        .png format</p>
                                                                </div>
                                                                <!--end col-->
                                                                <table>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td><strong>Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
                                                                            <td>${staff.username}</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>First name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
                                                                            <td>${staff.firstname}</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Last name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
                                                                            <td>${staff.lastname}</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Gender:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
                                                                            <td>${staff.gender}</td>
                                                                        </tr> 
                                                                        <tr>
                                                                            <td><strong>Adress:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
                                                                            <td>${staff.address}</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Phone number:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
                                                                            <td>${staff.phone}</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Email:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
                                                                            <td>${staff.email}</td>
                                                                        </tr> 
                                                                    </tbody>
                                                                </table>
                                                                <form action="ConsultantProfile" method="post" class="mt-4 form-update-account" enctype="multipart/form-data">
                                                                    <div class="container">
                                                                        <input name="changeInfo" value="changeInfo" type="hidden">
                                                                        <div class="col-md-12">
                                                                            <div class="mb-3 mt-4">
                                                                                <label for="otherImage">Image</label>
                                                                                <input type="file" id="otherImage" name="otherImage" class="form-control-file" accept=".jpg,.png">
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-12">
                                                                            <div class="mb-3 mt-4">
                                                                                <label class="form-label">Username <span class="text-danger">*</span></label>
                                                                                <input type="text" class="form-control username" value="${staff.username}" name="username">
                                                                                <small class="text-danger usernameError" style="display: none;">Username không được chứa space hoặc kí tự đặc biệt.</small>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <div class="mb-3">
                                                                                <label class="form-label">First Name <span class="text-danger">*</span></label>
                                                                                <input type="text" class="form-control firstname" value="${staff.firstname}" placeholder="First Name" name="firstname">
                                                                                <small class="text-danger firstnameError" style="display: none;">First name không được chứa số và kí tự được biệt</small>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <div class="mb-3">
                                                                                <label class="form-label">Last Name <span class="text-danger">*</span></label>
                                                                                <input type="text" class="form-control lastname" value="${staff.lastname}" placeholder="Last Name" name="lastname">
                                                                                <small class="text-danger lastnameError" style="display: none;">Last name không được chứa số và kí tự được biệt</small>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-12">
                                                                            <div class="mb-3">
                                                                                <label class="form-label">Day of birth <span class="text-danger">*</span></label>
                                                                                <input type="date" class="form-control dob" name="dob" value="${staff.dob}">
                                                                                <small class="dobError text-danger" style="display: none;">Customer phải ít nhất 18 tuổi trở lên.</small>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-12">
                                                                            <div class="mb-3">
                                                                                <label class="form-label">Gender <span class="text-danger">*</span></label>
                                                                                <select class="form-control" name="gender" required>
                                                                                    <option value="Male" ${staff.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                                                    <option value="Female" ${staff.gender == 'Female' ? 'selected' : ''}>Female</option>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-12">
                                                                            <div class="mb-3">
                                                                                <label class="form-label">Address <span class="text-danger">*</span></label>
                                                                                <input type="text" class="form-control" placeholder="Address" value="${staff.address}" name="address">
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-12">
                                                                            <div class="mb-3">
                                                                                <label class="form-label">Phone number <span class="text-danger">*</span></label>
                                                                                <input type="tel" class="form-control phone" name="phoneNumber" placeholder="Phone number" value="" pattern="0[1-9]\d{7,8}">
                                                                                <small class="text-danger phoneError" style="display: none;">Vui lòng nhập đúng format số điện thoại (9-10 số và không kí tự đặc biệt)</small>
                                                                            </div>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <div class="col-sm-12">
                                                                                <button type="submit" class="btn btn-primary">Edit</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </form><!--end form-->
                                                            </div>
                                                        </div>
                                                    </div><!--end col-->
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="rounded shadow mt-4">
                                                        <div class="p-4 border-bottom">
                                                            <strong class="mb-0">Thông tin cá nhân :</strong>
                                                        </div>

                                                        <div class="p-4">
                                                            <form action="ConsultantProfile" method="post" class="form-update-email">
                                                                <input name="changeEmail" value="changeEmail" type="hidden">
                                                                <div class="row">
                                                                    <div class="col-lg-12">
                                                                        <div class="mb-3">
                                                                            <label class="form-label"> 
                                                                                <div><strong>Email:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></div>
                                                                                <div> ${staff.email} </div>
                                                                            </label>
                                                                            <input type="email" class="form-control email"
                                                                                   placeholder="New Email" name="updateEmail"
                                                                                   required="">
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-lg-12 mt-2 mb-0">
                                                                        <button class="btn btn-primary">Save
                                                                        </button>
                                                                    </div><!--end col-->
                                                                </div><!--end row-->
                                                            </form>
                                                        </div>
                                                    </div>
                                                    <div class="rounded shadow mt-4">
                                                        <div class="p-4 border-bottom">
                                                            <strong class="mb-0">Đăng nhập tài khoản Smartbank :</strong>
                                                        </div>

                                                        <div class="p-4">
                                                            <form action="ConsultantProfile" method="post" class="form-update-password">
                                                                <input name="changePwd" value="changePwd" type="hidden">
                                                                <div class="row">
                                                                    <div class="col-lg-12">
                                                                        <div class="mb-3 position-relative">
                                                                            <label class="form-label">Old password
                                                                                :</label>
                                                                            <input type="password" class="form-control disableCheckPassword" name="currentpassword"
                                                                                   placeholder="Old password" id="oldPassword" required="">
                                                                            <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('oldPassword', 'toggleOldPasswordIcon')" style="padding-top: 30px;">
                                                                                <i id="toggleOldPasswordIcon" class="mdi mdi-eye-outline"></i>
                                                                            </span>
                                                                            <small class="passwordError text-danger" style="display: none;">Password phải có ít nhất 8 kí tự, chữ cái in hoa, số và 1 kí tự đặc biệt</small>
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-lg-12">
                                                                        <div class="mb-3 position-relative">
                                                                            <label class="form-label">New password
                                                                                :</label>
                                                                            <input type="password" class="form-control password" name="newpassword"
                                                                                   placeholder="New password" id="newPassword" required="">
                                                                            <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('newPassword', 'toggleNewPasswordIcon')" style="padding-top: 30px;">
                                                                                <i id="toggleNewPasswordIcon" class="mdi mdi-eye-outline"></i>
                                                                            </span>
                                                                            <small class="passwordError text-danger" style="display: none;">Password phải có ít nhất 8 kí tự, chữ cái in hoa, số và 1 kí tự đặc biệt</small>
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-lg-12">
                                                                        <div class="mb-3 position-relative">
                                                                            <label class="form-label">Re-type New
                                                                                password :</label>
                                                                            <input type="password" class="form-control password" name="confirmpassword"
                                                                                   placeholder="Re-type New password"
                                                                                   id="retypeNewPassword" required="">
                                                                            <span class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer" onclick="togglePassword('retypeNewPassword', 'toggleRetypePasswordIcon')" style="padding-top: 30px;">
                                                                                <i id="toggleRetypePasswordIcon" class="mdi mdi-eye-outline"></i>
                                                                            </span>
                                                                            <small class="passwordError text-danger" style="display: none;">Password phải có ít nhất 8 kí tự, chữ cái in hoa, số và 1 kí tự đặc biệt</small>
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-lg-12 mt-2 mb-0">
                                                                        <button class="btn btn-primary">Save
                                                                            password</button>
                                                                    </div><!--end col-->
                                                                </div><!--end row-->
                                                            </form>
                                                        </div>
                                                    </div>
                                                    <div class="rounded shadow mt-4">
                                                        <div class="p-4 border-bottom">
                                                            <h6 class="mb-0">General Notifications :</h6>
                                                        </div>
                                                        <form action="ConsultantProfile" method="post" onsubmit="return confirmDelete()">
                                                            <div class="p-4">
                                                                <div class="p-4 border-bottom">
                                                                    <h5 class="mb-0 text-danger">Delete Account :</h5>
                                                                </div>

                                                                <div class="p-4">
                                                                    <h6 class="mb-0 fw-normal">Bạn có muốn xóa
                                                                        tài khoản? Vui lòng nhấn nút "Xóa" bên dưới</h6>
                                                                    <div class="mt-4">
                                                                        <button type="submit" class="btn btn-danger">Delete
                                                                            Account</button>
                                                                    </div><!--end col-->
                                                                </div>
                                                            </div>
                                                        </form>    
                                                    </div>
                                                </div><!--end col-->
                                            </div><!--end row-->
                                        </div><!--end teb pane-->
                                    </div><!--end tab content-->
                                </div>                                                
                            </div><!--end col-->
                        </div><!--end row-->
                    </div>
                </div>
            </div><!--end container-->
            <script>
                document.querySelectorAll(".form-update-account").forEach(function (form) {
                    // Username Validation
                    form.querySelectorAll(".username").forEach(function (input) {
                        input.addEventListener("input", function () {
                            const username = this.value;
                            const usernamePattern = /^[\p{L}0-9]+$/u;
                            const errorMsg = form.querySelector(".usernameError");

                            if (!usernamePattern.test(username)) {
                                errorMsg.style.display = "block";
                                this.setCustomValidity("Username must not contain spaces or special characters.");
                            } else {
                                errorMsg.style.display = "none";
                                this.setCustomValidity("");
                            }
                        });
                    });

                    // First Name Validation
                    form.querySelectorAll(".firstname").forEach(function (input) {
                        input.addEventListener("input", function () {
                            const firstname = this.value;
                            const namePattern = /^[\p{L}0-9]+$/u;
                            const errorMsg = form.querySelector(".firstnameError");

                            if (!namePattern.test(firstname)) {
                                errorMsg.style.display = "block";
                                this.setCustomValidity("First name must only contain letters.");
                            } else {
                                errorMsg.style.display = "none";
                                this.setCustomValidity("");
                                this.value = capitalize(firstname); // Capitalize the first letter
                            }
                        });
                    });

                    // Last Name Validation
                    form.querySelectorAll(".lastname").forEach(function (input) {
                        input.addEventListener("input", function () {
                            const lastname = this.value;
                            const namePattern = /^[\p{L}0-9]+$/u;
                            const errorMsg = form.querySelector(".lastnameError");

                            if (!namePattern.test(lastname)) {
                                errorMsg.style.display = "block";
                                this.setCustomValidity("Last name must only contain letters.");
                            } else {
                                errorMsg.style.display = "none";
                                this.setCustomValidity("");
                                this.value = capitalize(lastname); // Capitalize the first letter
                            }
                        });
                    });

                    // Phone Validation
                    form.querySelectorAll(".phone").forEach(function (input) {
                        input.addEventListener("input", function () {
                            let phoneInput = this.value;
                            let phonePattern = /^0[1-9]\d{7,8}$/;
                            let errorMsg = form.querySelector(".phoneError");

                            if (phonePattern.test(phoneInput)) {
                                this.setCustomValidity("");
                                errorMsg.style.display = "none";
                            } else {
                                this.setCustomValidity("Phone number không đúng format");
                                errorMsg.style.display = "block";
                            }
                        });
                    });

                    // Email Validation
                    form.querySelectorAll(".email").forEach(function (input) {
                        input.addEventListener("input", function () {
                            let email = this.value;
                            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                            let errorMsg = form.querySelector(".emailError");

                            if (emailPattern.test(email)) {
                                this.setCustomValidity(""); // ✅ Allow form submission
                                errorMsg.style.display = "none"; // ✅ Hide error message
                            } else {
                                this.setCustomValidity("Email không đúng format"); // ❌ Prevent form submission
                                errorMsg.style.display = "block"; // ❌ Show error message
                            }
                        });
                    });

                    // Date of Birth Validation (18+)
                    form.querySelectorAll(".dob").forEach(function (input) {
                        input.addEventListener("change", function () {
                            const dobInput = this.value;
                            const dobError = form.querySelector(".dobError");

                            if (dobInput) {
                                const dob = new Date(dobInput);
                                const today = new Date();
                                const age = today.getFullYear() - dob.getFullYear();
                                const monthDiff = today.getMonth() - dob.getMonth();
                                const dayDiff = today.getDate() - dob.getDate();

                                const actualAge = (monthDiff < 0 || (monthDiff === 0 && dayDiff < 0)) ? age - 1 : age;

                                if (actualAge < 18) {
                                    dobError.style.display = "block";
                                    this.setCustomValidity("You must be at least 18 years old.");
                                } else {
                                    dobError.style.display = "none";
                                    this.setCustomValidity("");
                                }
                            }
                        });
                    });
                });
                document.querySelector(".form-update-password").querySelectorAll(".password").forEach(function (input) {
                    input.addEventListener("input", function () {
                        const password = this.value;
                        const passwordPattern = /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
                        const errorMsg = this.closest(".position-relative").querySelector(".passwordError");

                        if (passwordPattern.test(password)) {
                            this.setCustomValidity("");
                            errorMsg.style.display = "none";
                        } else {
                            this.setCustomValidity("Password must be at least 8 characters long, include at least one uppercase letter, one number, and one special character.");
                            errorMsg.style.display = "block";
                        }
                    });
                });
            </script>
            <script>
                $(document).ready(function () {
                    $(".form-update-account, .form-update-email, .form-update-password").submit(function (event) {
                        event.preventDefault(); // Stop default form submission

                        var formData = new FormData(this); // Collect form data

                        $.ajax({
                            url: "ConsultantProfile", // Servlet URL
                            type: "POST",
                            data: formData,
                            processData: false,
                            contentType: false,
                            success: function (response) {
                                if (response === "errorPhoneExist") {
                                    alert("Số điện thoại đã có người sử dụng, vui lòng nhập số điện thoại khác.");
                                } 
                                else if (response === "errorEmailexist") {
                                    alert("Email đã có người sử dụng, vui lòng nhập email khác.");
                                }
                                else if (response === "errorImageSize") {
                                    alert("Image lớn hơn 5mb");
                                }
                                else if (response === "errorImageType") {
                                    alert("Image không đúng định dạng jpg, png, jpeg");
                                }
                                else if (response === "errorCheckPassword") {
                                    alert("password không đúng");
                                } 
                                else if (response === "errorConfirmPassword") {
                                    alert("Confirm password không đúng");
                                }
                                else {
                                    alert("Tài khoản được cập nhật thành công!");
                                    location.reload();
                                }
                            },
                            error: function () {
                                alert("Có lỗi xảy ra, vui lòng thử lại.");
                            }
                        });
                    });
                });
            </script>
            <script>
                let confirmed = false;

                function confirmDelete() {
                    if (!confirmed) {
                        confirmed = confirm("Bạn có thực sự muốn xóa tài khoản này không?, hành động này không thể hoàn tác.");
                        return false; // Prevent form submission initially
                    }
                    return true; // Allow submission on second click
                }

            </script>
            <script>
                function togglePassword(passwordFieldId, iconId) {
                    var passwordField = document.getElementById(passwordFieldId);
                    var toggleIcon = document.getElementById(iconId);

                    if (passwordField.type === "password") {
                        passwordField.type = "text";
                        toggleIcon.classList.remove("mdi-eye-outline");
                        toggleIcon.classList.add("mdi-eye-off-outline");
                    } else {
                        passwordField.type = "password";
                        toggleIcon.classList.remove("mdi-eye-off-outline");
                        toggleIcon.classList.add("mdi-eye-outline");
                    }
                }
            </script>
            <!-- Footer Start -->
            <jsp:include page="template/footer.jsp"/>
            <!-- End -->
        </main>
        <!--End page-content" -->
    </div>
    <!-- page-wrapper -->

    <!-- Offcanvas Start -->

    <!-- javascript -->
    <script src="<%= request.getContextPath() %>/assets/js/jquery.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
    <!-- simplebar -->
    <script src="<%= request.getContextPath() %>/assets/js/simplebar.min.js"></script>
    <!-- Select2 -->
    <script src="<%= request.getContextPath() %>/assets/js/select2.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/select2.init.js"></script>
    <!-- Datepicker -->
    <script src="<%= request.getContextPath() %>/assets/js/flatpickr.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/flatpickr.init.js"></script>
    <!-- Datepicker -->
    <script src="<%= request.getContextPath() %>/assets/js/jquery.timepicker.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/timepicker.init.js"></script>
    <!-- Icons -->
    <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>

</body>

</html>
