<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Doctris - Doctor Appointment Booking System</title>
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
    <!-- Icons -->
    <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="<%= request.getContextPath() %>/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- SLIDER -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/tiny-slider.css" />
    <!-- Css -->
    <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
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

    <!-- Navbar Start -->
    <header id="topnav" class="navigation sticky">
        <div class="container">
            <!-- Logo container-->
            <div>
                <a class="logo" href="index.jsp">
                    <span class="logo-light-mode">
                        <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" class="l-dark" height="24" alt="">
                        <img src="<%= request.getContextPath() %>/assets/images/logo-light.png" class="l-light" height="24" alt="">
                    </span>
                    <img src="<%= request.getContextPath() %>/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                </a>
            </div>
            <!-- End Logo container-->

            <!-- Start Mobile Toggle -->
            <div class="menu-extras">
                <div class="menu-item">
                    <!-- Mobile menu toggle-->
                    <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                        <div class="lines">
                            <span></span>
                            <span></span>
                            <span></span>
                        </div>
                    </a>
                    <!-- End mobile menu toggle-->
                </div>
            </div>
            <!-- End Mobile Toggle -->

            <!-- Start Dropdown -->
            <ul class="dropdowns list-inline mb-0">
                <li class="list-inline-item mb-0">
                    <a href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
                        aria-controls="offcanvasRight">
                        <div class="btn btn-icon btn-pills btn-primary"><i data-feather="settings"
                                class="fea icon-sm"></i></div>
                    </a>
                </li>

                <li class="list-inline-item mb-0 ms-1">
                    <a href="javascript:void(0)" class="btn btn-icon btn-pills btn-primary" data-bs-toggle="offcanvas"
                        data-bs-target="#offcanvasTop" aria-controls="offcanvasTop">
                        <i class="uil uil-search"></i>
                    </a>
                </li>

                <li class="list-inline-item mb-0 ms-1">
                    <div class="dropdown dropdown-primary">
                        <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0"
                            data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img
                                src="<%= request.getContextPath() %>/assets/images/doctors/01.jpg" class="avatar avatar-ex-small rounded-circle"
                                alt=""></button>
                        <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3"
                            style="min-width: 200px;">
                            <a class="dropdown-item d-flex align-items-center text-dark" href="doctor-profile.jsp">
                                <img src="<%= request.getContextPath() %>/assets/images/doctors/01.jpg"
                                    class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                <div class="flex-1 ms-2">
                                    <span class="d-block mb-1">Calvin Carlo</span>
                                    <small class="text-muted">Orthopedic</small>
                                </div>
                            </a>
                            <a class="dropdown-item text-dark" href="doctor-dashboard.jsp"><span
                                    class="mb-0 d-inline-block me-1"><i
                                        class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                            <a class="dropdown-item text-dark" href="doctor-profile-setting.jsp"><span
                                    class="mb-0 d-inline-block me-1"><i
                                        class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                            <div class="dropdown-divider border-top"></div>
                            <a class="dropdown-item text-dark" href="login.jsp"><span
                                    class="mb-0 d-inline-block me-1"><i
                                        class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                        </div>
                    </div>
                </li>
            </ul>
            <!-- Start Dropdown -->

            <div id="navigation">
                <!-- Navigation Menu-->
                <ul class="navigation-menu nav-left nav-light">
                    <li class="has-submenu parent-menu-item">
                        <a href="javascript:void(0)">Home</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="index.jsp" class="sub-menu-item">Index One</a></li>
                            <li><a href="index-two.jsp" class="sub-menu-item">Index Two</a></li>
                            <li><a href="index-three.jsp" class="sub-menu-item">Index Three</a></li>
                        </ul>
                    </li>

                    <li class="has-submenu parent-parent-menu-item">
                        <a href="javascript:void(0)">Doctors</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li class="has-submenu parent-menu-item">
                                <a href="javascript:void(0)" class="menu-item"> Dashboard </a><span
                                    class="submenu-arrow"></span>
                                <ul class="submenu">
                                    <li><a href="doctor-dashboard.jsp" class="sub-menu-item">Dashboard</a></li>
                                    <li><a href="doctor-appointment.jsp" class="sub-menu-item">Appointment</a></li>
                                    <li><a href="patient-list.jsp" class="sub-menu-item">Patients</a></li>
                                    <li><a href="doctor-schedule.jsp" class="sub-menu-item">Schedule Timing</a></li>
                                    <li><a href="invoices.jsp" class="sub-menu-item">Invoices</a></li>
                                    <li><a href="patient-review.jsp" class="sub-menu-item">Reviews</a></li>
                                    <li><a href="doctor-messages.jsp" class="sub-menu-item">Messages</a></li>
                                    <li><a href="doctor-profile.jsp" class="sub-menu-item">Profile</a></li>
                                    <li><a href="doctor-profile-setting.jsp" class="sub-menu-item">Profile Settings</a>
                                    </li>
                                    <li><a href="doctor-chat.jsp" class="sub-menu-item">Chat</a></li>
                                    <li><a href="login.jsp" class="sub-menu-item">Login</a></li>
                                    <li><a href="signup.jsp" class="sub-menu-item">Sign Up</a></li>
                                    <li><a href="forgot-password.jsp" class="sub-menu-item">Forgot Password</a></li>
                                </ul>
                            </li>
                            <li><a href="doctor-team-one.jsp" class="sub-menu-item">Doctors One</a></li>
                            <li><a href="doctor-team-two.jsp" class="sub-menu-item">Doctors Two</a></li>
                            <li><a href="doctor-team-three.jsp" class="sub-menu-item">Doctors Three</a></li>
                        </ul>
                    </li>

                    <li class="has-submenu parent-menu-item">
                        <a href="javascript:void(0)">Patients</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="patient-dashboard.jsp" class="sub-menu-item">Dashboard</a></li>
                            <li><a href="patient-profile.jsp" class="sub-menu-item">Profile</a></li>
                            <li><a href="booking-appointment.jsp" class="sub-menu-item">Book Appointment</a></li>
                            <li><a href="patient-invoice.jsp" class="sub-menu-item">Invoice</a></li>
                        </ul>
                    </li>

                    <li class="has-submenu parent-menu-item">
                        <a href="javascript:void(0)">Pharmacy</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="pharmacy.jsp" class="sub-menu-item">Pharmacy</a></li>
                            <li><a href="pharmacy-shop.jsp" class="sub-menu-item">Shop</a></li>
                            <li><a href="pharmacy-product-detail.jsp" class="sub-menu-item">Medicine Detail</a></li>
                            <li><a href="pharmacy-shop-cart.jsp" class="sub-menu-item">Shop Cart</a></li>
                            <li><a href="pharmacy-checkout.jsp" class="sub-menu-item">Checkout</a></li>
                            <li><a href="pharmacy-account.jsp" class="sub-menu-item">Account</a></li>
                        </ul>
                    </li>

                    <li class="has-submenu parent-parent-menu-item"><a href="javascript:void(0)">Pages</a><span
                            class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="aboutus.html" class="sub-menu-item"> About Us</a></li>
                            <li><a href="departments.html" class="sub-menu-item">Departments</a></li>
                            <li><a href="faqs.html" class="sub-menu-item">FAQs</a></li>
                            <li class="has-submenu parent-menu-item">
                                <a href="javascript:void(0)" class="menu-item"> Blogs </a><span
                                    class="submenu-arrow"></span>
                                <ul class="submenu">
                                    <li><a href="blogs.html" class="sub-menu-item">Blogs</a></li>
                                    <li><a href="blog-detail.html" class="sub-menu-item">Blog Details</a></li>
                                </ul>
                            </li>
                            <li><a href="terms.html" class="sub-menu-item">Terms & Policy</a></li>
                            <li><a href="privacy.html" class="sub-menu-item">Privacy Policy</a></li>
                            <li><a href="error.html" class="sub-menu-item">404 !</a></li>
                            <li><a href="contact.html" class="sub-menu-item">Contact</a></li>
                        </ul>
                    </li>
                    <li><a href="change-password.jsp" class="sub-menu-item" target="_blank">Change PassWord</a></li>
                </ul><!--end navigation menu-->
            </div><!--end navigation-->
        </div><!--end container-->
    </header><!--end header-->
    <!-- Navbar End -->

    <!-- Start Hero -->
    <section class="bg-half-260 d-table w-100" style="background: url('<%= request.getContextPath() %>/assets/images/bg/01.jpg') center;">
        <div class="bg-overlay bg-overlay-dark"></div>
        <div class="container">
            <div class="row mt-5 mt-lg-0">
                <div class="col-12">
                    <div class="heading-title">
                        <img src="<%= request.getContextPath() %>/assets/images/logo-icon2.png" height="50" alt="">
                        <h4 class="display-4 fw-bold text-white title-dark mt-3 mb-4">Meet The <br> Best Doctor</h4>
                        <p class="para-desc text-white-50 mb-0">Great doctor if you need your family member to get
                            effective immediate assistance, emergency treatment or a simple consultation.</p>

                        <div class="mt-4 pt-2">
                            <a href="booking-appointment.html" class="btn btn-primary">Make Appointment</a>
                            <p class="text-white-50 mb-0 mt-2">T&C apply. Please read <a href="#"
                                    class="text-white-50">Terms and Conditions <i
                                        class="ri-arrow-right-line align-middle"></i></a></p>
                        </div>
                    </div>
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->
    </section><!--end section-->
    <!-- End Hero -->

    <!-- Start -->
    <section class="section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-10">
                    <div class="features-absolute bg-white shadow rounded overflow-hidden card-group">
                        <div class="card border-0 bg-light p-4">
                            <i class="ri-heart-pulse-fill text-primary h2 mb-0"></i>
                            <h5 class="mt-1">Emergency Cases</h5>
                            <p class="text-muted mt-2">This is required when, for example, the is not yet available.
                                Dummy text is also known as 'fill text'.</p>
                            <a href="departments.html" class="text-primary">Read More <i
                                    class="ri-arrow-right-line align-middle"></i></a>
                        </div>

                        <div class="card border-0 p-4">
                            <i class="ri-dossier-fill text-primary h2 mb-0"></i>
                            <h5 class="mt-1">Doctors Timetable</h5>
                            <p class="text-muted mt-2">This is required when, for example, the is not yet available.
                                Dummy text is also known as 'fill text'.</p>
                            <a href="departments.html" class="text-primary">Read More <i
                                    class="ri-arrow-right-line align-middle"></i></a>
                        </div>

                        <div class="card border-0 bg-light p-4">
                            <i class="ri-time-fill text-primary h2 mb-0"></i>
                            <h5 class="mt-1">Opening Hours</h5>
                            <ul class="list-unstyled mt-2">
                                <li class="d-flex justify-content-between">
                                    <p class="text-muted mb-0">Monday - Friday</p>
                                    <p class="text-primary mb-0">8.00 - 20.00</p>
                                </li>
                                <li class="d-flex justify-content-between">
                                    <p class="text-muted mb-0">Saturday</p>
                                    <p class="text-primary mb-0">8.00 - 18.00</p>
                                </li>
                                <li class="d-flex justify-content-between">
                                    <p class="text-muted mb-0">Sunday</p>
                                    <p class="text-primary mb-0">8.00 - 14.00</p>
                                </li>
                            </ul>
                            <a href="departments.html" class="text-primary">Read More <i
                                    class="ri-arrow-right-line align-middle"></i></a>
                        </div>
                    </div>
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->

        <div class="container mt-100 mt-60">
            <div class="row align-items-center">
                <div class="col-lg-5 col-md-6">
                    <div class="position-relative">
                        <img src="<%= request.getContextPath() %>/assets/images/about/about-2.png" class="img-fluid" alt="">
                        <div class="play-icon">
                            <a href="#" data-bs-toggle="modal" data-bs-target="#watchvideomodal"
                                class="play-btn video-play-icon">
                                <i class="mdi mdi-play text-primary rounded-circle bg-white title-bg-dark shadow"></i>
                            </a>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-lg-7 col-md-6 mt-4 mt-lg-0 pt- pt-lg-0">
                    <div class="ms-lg-4">
                        <div class="section-title">
                            <h4 class="title mb-4">About Our Treatments</h4>
                            <p class="text-muted para-desc">Great doctor if you need your family member to get effective
                                immediate assistance, examination, emergency treatment or a simple consultation. Thank
                                you.</p>
                            <p class="text-muted para-desc mb-0">The most well-known dummy text is the 'Lorem Ipsum',
                                which is said to have originated in the 16th century. Lorem Ipsum is composed in a
                                pseudo-Latin language which more or less corresponds to 'proper' Latin. It contains a
                                series of real Latin words.</p>
                        </div>

                        <div class="mt-4">
                            <a href="aboutus.html" class="btn btn-primary">Read More <i
                                    class="ri-arrow-right-line align-middle"></i></a>
                        </div>
                    </div>
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->

        <div class="container mt-100 mt-60">
            <div class="row justify-content-center">
                <div class="col-12">
                    <div class="section-title mb-4 pb-2 text-center">
                        <span class="badge badge-pill badge-soft-primary mb-3">Departments</span>
                        <h4 class="title mb-4">Our Medical Services</h4>
                        <p class="text-muted mx-auto para-desc mb-0">Great doctor if you need your family member to get
                            effective immediate assistance, emergency treatment or a simple consultation.</p>
                    </div>
                </div><!--end col-->
            </div><!--end row-->

            <div class="row">
                <div class="col-xl-3 col-md-4 col-12 mt-5">
                    <div class="card features feature-primary border-0">
                        <div class="icon text-center rounded-md">
                            <i class="ri-eye-fill h3 mb-0"></i>
                        </div>
                        <div class="card-body p-0 mt-3">
                            <a href="departments.html" class="title text-dark h5">Eye Care</a>
                            <p class="text-muted mt-3">There is now an abundance of readable dummy texts required purely
                                to fill a space.</p>
                            <a href="departments.html" class="link">Read More <i
                                    class="ri-arrow-right-line align-middle"></i></a>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-3 col-md-4 col-12 mt-5">
                    <div class="card features feature-primary border-0">
                        <div class="icon text-center rounded-md">
                            <i class="ri-psychotherapy-fill h3 mb-0"></i>
                        </div>
                        <div class="card-body p-0 mt-3">
                            <a href="departments.html" class="title text-dark h5">Psychotherapy</a>
                            <p class="text-muted mt-3">There is now an abundance of readable dummy texts required purely
                                to fill a space.</p>
                            <a href="departments.html" class="link">Read More <i
                                    class="ri-arrow-right-line align-middle"></i></a>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-3 col-md-4 col-12 mt-5">
                    <div class="card features feature-primary border-0">
                        <div class="icon text-center rounded-md">
                            <i class="ri-stethoscope-fill h3 mb-0"></i>
                        </div>
                        <div class="card-body p-0 mt-3">
                            <a href="departments.html" class="title text-dark h5">Primary Care</a>
                            <p class="text-muted mt-3">There is now an abundance of readable dummy texts required purely
                                to fill a space.</p>
                            <a href="departments.html" class="link">Read More <i
                                    class="ri-arrow-right-line align-middle"></i></a>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-3 col-md-4 col-12 mt-5">
                    <div class="card features feature-primary border-0">
                        <div class="icon text-center rounded-md">
                            <i class="ri-capsule-fill h3 mb-0"></i>
                        </div>
                        <div class="card-body p-0 mt-3">
                            <a href="departments.html" class="title text-dark h5">Dental Care</a>
                            <p class="text-muted mt-3">There is now an abundance of readable dummy texts required purely
                                to fill a space.</p>
                            <a href="departments.html" class="link">Read More <i
                                    class="ri-arrow-right-line align-middle"></i></a>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-3 col-md-4 col-12 mt-5">
                    <div class="card features feature-primary border-0">
                        <div class="icon text-center rounded-md">
                            <i class="ri-microscope-fill h3 mb-0"></i>
                        </div>
                        <div class="card-body p-0 mt-3">
                            <a href="departments.html" class="title text-dark h5">Orthopedic</a>
                            <p class="text-muted mt-3">There is now an abundance of readable dummy texts required purely
                                to fill a space.</p>
                            <a href="departments.html" class="link">Read More <i
                                    class="ri-arrow-right-line align-middle"></i></a>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-3 col-md-4 col-12 mt-5">
                    <div class="card features feature-primary border-0">
                        <div class="icon text-center rounded-md">
                            <i class="ri-pulse-fill h3 mb-0"></i>
                        </div>
                        <div class="card-body p-0 mt-3">
                            <a href="departments.html" class="title text-dark h5">Cardiology</a>
                            <p class="text-muted mt-3">There is now an abundance of readable dummy texts required purely
                                to fill a space.</p>
                            <a href="departments.html" class="link">Read More <i
                                    class="ri-arrow-right-line align-middle"></i></a>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-3 col-md-4 col-12 mt-5">
                    <div class="card features feature-primary border-0">
                        <div class="icon text-center rounded-md">
                            <i class="ri-empathize-fill h3 mb-0"></i>
                        </div>
                        <div class="card-body p-0 mt-3">
                            <a href="departments.html" class="title text-dark h5">Gynecology</a>
                            <p class="text-muted mt-3">There is now an abundance of readable dummy texts required purely
                                to fill a space.</p>
                            <a href="departments.html" class="link">Read More <i
                                    class="ri-arrow-right-line align-middle"></i></a>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-3 col-md-4 col-12 mt-5">
                    <div class="card features feature-primary border-0">
                        <div class="icon text-center rounded-md">
                            <i class="ri-mind-map h3 mb-0"></i>
                        </div>
                        <div class="card-body p-0 mt-3">
                            <a href="departments.html" class="title text-dark h5">Neurology</a>
                            <p class="text-muted mt-3">There is now an abundance of readable dummy texts required purely
                                to fill a space.</p>
                            <a href="departments.html" class="link">Read More <i
                                    class="ri-arrow-right-line align-middle"></i></a>
                        </div>
                    </div>
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->
    </section><!--end section-->
    <!-- End -->

    <!-- Start -->
    <section class="section bg-light">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12">
                    <div class="section-title text-center mb-4 pb-2">
                        <span class="badge badge-pill badge-soft-primary mb-3">Availability</span>
                        <h4 class="title mb-4">Doctors Time Table</h4>
                        <p class="text-muted mx-auto para-desc mb-0">Great doctor if you need your family member to get
                            effective immediate assistance, emergency treatment or a simple consultation.</p>
                    </div>
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->

        <div class="container-fluid">
            <div class="row">
                <div class="col-12 mt-4 pt-2">
                    <div class="table-responsive shadow rounded">
                        <table class="table table-center table-bordered bg-white mb-0">
                            <thead>
                                <tr>
                                    <th class="text-center py-4" style="min-width: 120px;">Time Table</th>
                                    <th class="text-center py-4" style="min-width: 200px;">Monday</th>
                                    <th class="text-center py-4" style="min-width: 200px;">Tuesday</th>
                                    <th class="text-center py-4" style="min-width: 200px;">Wednesday</th>
                                    <th class="text-center py-4" style="min-width: 200px;">Thursday</th>
                                    <th class="text-center py-4" style="min-width: 200px;">Friday</th>
                                    <th class="text-center py-4" style="min-width: 200px;">Saturday</th>
                                    <th class="text-center py-4" style="min-width: 200px;">Sunday</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Start -->
                                <tr>
                                    <th class="text-center py-5">09:00AM</th>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/01.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Calvin Carlo</h6>
                                                <small class="text-muted">Eye Care</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">09:00AM -
                                            10:00AM</small>
                                    </td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/03.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Alia Reddy</h6>
                                                <small class="text-muted">Psychotherapy</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">09:00AM -
                                            01:00PM</small>
                                    </td>
                                    <td></td>
                                    <td></td>
                                </tr>

                                <tr>
                                    <th class="text-center py-5">11:00AM</th>
                                    <td></td>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/02.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Cristino Murphy</h6>
                                                <small class="text-muted">Gynecology</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">11:00AM -
                                            04:00PM</small>
                                    </td>
                                    <td></td>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/05.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Jennifer Ballance</h6>
                                                <small class="text-muted">Cardiology</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">11:00AM -
                                            12:00PM</small>
                                    </td>
                                    <td></td>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/04.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Toni Kovar</h6>
                                                <small class="text-muted">Orthopedic</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">09:00AM -
                                            10:00AM</small>
                                    </td>
                                    <td></td>
                                </tr>

                                <tr>
                                    <th class="text-center py-5">02:00PM</th>
                                    <td></td>
                                    <td></td>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/06.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Tara Arrington</h6>
                                                <small class="text-muted">Neurology</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">02:00PM -
                                            04:00PM</small>
                                    </td>
                                    <td></td>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/05.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Jennifer Ballance</h6>
                                                <small class="text-muted">Cardiology</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">11:00AM -
                                            12:00PM</small>
                                    </td>
                                    <td></td>
                                    <td></td>
                                </tr>

                                <tr>
                                    <th class="text-center py-5">04:00PM</th>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/06.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Tara Arrington</h6>
                                                <small class="text-muted">Neurology</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">04:00PM -
                                            05:00PM</small>
                                    </td>
                                    <td></td>
                                    <td></td>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/06.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Tara Arrington</h6>
                                                <small class="text-muted">Neurology</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">04:30PM -
                                            06:00PM</small>
                                    </td>
                                </tr>

                                <tr>
                                    <th class="text-center py-5">06:00PM</th>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/03.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Alia Reddy</h6>
                                                <small class="text-muted">Psychotherapy</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">06:00PM -
                                            09:00PM</small>
                                    </td>
                                    <td></td>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/04.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Toni Kovar</h6>
                                                <small class="text-muted">Orthopedic</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">07:00PM -
                                            08:00PM</small>
                                    </td>
                                    <td></td>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/05.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Jennifer Ballance</h6>
                                                <small class="text-muted">Cardiology</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">06:00PM -
                                            07:00PM</small>
                                    </td>
                                    <td></td>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/03.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Alia Reddy</h6>
                                                <small class="text-muted">Psychotherapy</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">06:00PM -
                                            07:00PM</small>
                                    </td>
                                </tr>

                                <tr>
                                    <th class="text-center py-5">09:00PM</th>
                                    <td></td>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/04.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Toni Kovar</h6>
                                                <small class="text-muted">Orthopedic</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">09:00PM -
                                            10:00PM</small>
                                    </td>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/05.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Jennifer Ballance</h6>
                                                <small class="text-muted">Cardiology</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">09:00PM -
                                            10:00PM</small>
                                    </td>
                                    <td></td>
                                    <td>
                                        <div class="d-flex mb-3">
                                            <img src="<%= request.getContextPath() %>/assets/images/doctors/04.jpg"
                                                class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="ms-3">
                                                <h6 class="text-dark mb-0 d-block">Toni Kovar</h6>
                                                <small class="text-muted">Orthopedic</small>
                                            </div>
                                        </div>
                                        <small class="bg-soft-primary rounded py-1 px-2 d-block text-center">09:00PM -
                                            10:00PM</small>
                                    </td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <!-- End -->
                            </tbody>
                        </table>
                    </div>
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-fluid-->
    </section><!--end section-->
    <!-- End -->

    <!-- Start -->
    <section class="section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12">
                    <div class="section-title text-center mb-4 pb-2">
                        <h4 class="title mb-4">Doctors</h4>
                        <p class="text-muted mx-auto para-desc mb-0">Great doctor if you need your family member to get
                            effective immediate assistance, emergency treatment or a simple consultation.</p>
                    </div>
                </div><!--end col-->
            </div><!--end row-->

            <div class="row align-items-center">
                <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                    <div class="card team border-0 rounded shadow overflow-hidden">
                        <div class="team-img position-relative">
                            <img src="<%= request.getContextPath() %>/assets/images/doctors/01.jpg" class="img-fluid" alt="">
                            <ul class="list-unstyled team-social mb-0">
                                <li><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="facebook" class="icons"></i></a></li>
                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="linkedin" class="icons"></i></a></li>
                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="github" class="icons"></i></a></li>
                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="twitter" class="icons"></i></a></li>
                            </ul>
                        </div>
                        <div class="card-body content text-center">
                            <a href="doctor-team-one.html" class="title text-dark h5 d-block mb-0">Calvin Carlo</a>
                            <small class="text-muted speciality">Eye Care</small>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                    <div class="card team border-0 rounded shadow overflow-hidden">
                        <div class="team-img position-relative">
                            <img src="<%= request.getContextPath() %>/assets/images/doctors/02.jpg" class="img-fluid" alt="">
                            <ul class="list-unstyled team-social mb-0">
                                <li><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="facebook" class="icons"></i></a></li>
                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="linkedin" class="icons"></i></a></li>
                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="github" class="icons"></i></a></li>
                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="twitter" class="icons"></i></a></li>
                            </ul>
                        </div>
                        <div class="card-body content text-center">
                            <a href="doctor-team-one.html" class="title text-dark h5 d-block mb-0">Cristino Murphy</a>
                            <small class="text-muted speciality">Gynecology</small>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                    <div class="card team border-0 rounded shadow overflow-hidden">
                        <div class="team-img position-relative">
                            <img src="<%= request.getContextPath() %>/assets/images/doctors/03.jpg" class="img-fluid" alt="">
                            <ul class="list-unstyled team-social mb-0">
                                <li><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="facebook" class="icons"></i></a></li>
                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="linkedin" class="icons"></i></a></li>
                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="github" class="icons"></i></a></li>
                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="twitter" class="icons"></i></a></li>
                            </ul>
                        </div>
                        <div class="card-body content text-center">
                            <a href="doctor-team-one.html" class="title text-dark h5 d-block mb-0">Alia Reddy</a>
                            <small class="text-muted speciality">Psychotherapy</small>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                    <div class="card team border-0 rounded shadow overflow-hidden">
                        <div class="team-img position-relative">
                            <img src="<%= request.getContextPath() %>/assets/images/doctors/04.jpg" class="img-fluid" alt="">
                            <ul class="list-unstyled team-social mb-0">
                                <li><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="facebook" class="icons"></i></a></li>
                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="linkedin" class="icons"></i></a></li>
                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="github" class="icons"></i></a></li>
                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i
                                            data-feather="twitter" class="icons"></i></a></li>
                            </ul>
                        </div>
                        <div class="card-body content text-center">
                            <a href="doctor-team-one.html" class="title text-dark h5 d-block mb-0">Toni Kovar</a>
                            <small class="text-muted speciality">Orthopedic</small>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-12 mt-4 pt-2 text-center">
                    <a href="doctor-team-one.html" class="btn btn-primary">See More</a>
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->
    </section><!--end section-->
    <!-- End -->

    <!-- Start -->
    <section class="section pt-0">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 text-center">
                    <div class="video-solution-cta position-relative" style="z-index: 1;">
                        <div class="position-relative">
                            <img src="<%= request.getContextPath() %>/assets/images/bg/01.jpg" class="img-fluid rounded-md shadow-lg" alt="">
                            <div class="play-icon">
                                <a href="#" data-bs-toggle="modal" data-bs-target="#watchvideomodal"
                                    class="play-btn video-play-icon">
                                    <i
                                        class="mdi mdi-play text-primary rounded-circle bg-white title-bg-dark shadow-lg"></i>
                                </a>
                            </div>
                        </div>

                        <div class="content">
                            <div class="row" id="counter">
                                <div class="col-md-4 mt-4 pt-2">
                                    <div class="counter-box text-center">
                                        <h1 class="mt-3 text-white title-dark"><span class="counter-value"
                                                data-target="99">10</span>%</h1>
                                        <h5 class="counter-head text-white title-dark mb-1">Positive feedback</h5>
                                        <p class="text-white-50 mb-0">From Doctors</p>
                                    </div><!--end counter box-->
                                </div><!--end col-->

                                <div class="col-md-4 mt-4 pt-2">
                                    <div class="counter-box text-center">
                                        <h1 class="mt-3 text-white title-dark"><span class="counter-value"
                                                data-target="25">2</span>+</h1>
                                        <h5 class="counter-head text-white title-dark mb-1">Experienced Clinics</h5>
                                        <p class="text-white-50 mb-0">High Qualified</p>
                                    </div><!--end counter box-->
                                </div><!--end col-->

                                <div class="col-md-4 mt-4 pt-2">
                                    <div class="counter-box text-center">
                                        <h1 class="mt-3 text-white title-dark"><span class="counter-value"
                                                data-target="1251">95</span>+</h1>
                                        <h5 class="counter-head text-white title-dark mb-1">Questions & Answers</h5>
                                        <p class="text-white-50 mb-0">Your Questions</p>
                                    </div><!--end counter box-->
                                </div><!--end col-->
                            </div><!--end row-->
                        </div>
                    </div>
                </div><!--end col-->
            </div><!--end row -->
            <div class="feature-posts-placeholder bg-primary"></div>
        </div><!--end container-->
    </section><!--end section-->
    <!-- End -->

    <!-- Start -->
    <section class="section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12">
                    <div class="section-title text-center mb-4 pb-2">
                        <h4 class="title mb-4">Patients Says</h4>
                        <p class="text-muted mx-auto para-desc mb-0">Great doctor if you need your family member to get
                            effective immediate assistance, emergency treatment or a simple consultation.</p>
                    </div>
                </div><!--end col-->
            </div><!--end row-->

            <div class="row justify-content-center">
                <div class="col-lg-8 mt-4 pt-2 text-center">
                    <div class="client-review-slider">
                        <div class="tiny-slide text-center">
                            <p class="text-muted h6 fw-normal fst-italic">" It seems that only fragments of the original
                                text remain in the Lorem Ipsum texts used today. The most well-known dummy text is the
                                'Lorem Ipsum', which is said to have originated in the 16th century. "</p>
                            <img src="<%= request.getContextPath() %>/assets/images/client/01.jpg"
                                class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                            <ul class="list-unstyled mb-0">
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                            </ul>
                            <h6 class="text-primary">- Thomas Israel <small class="text-muted">C.E.O</small></h6>
                        </div><!--end customer testi-->

                        <div class="tiny-slide text-center">
                            <p class="text-muted h6 fw-normal fst-italic">" The advantage of its Latin origin and the
                                relative meaninglessness of Lorum Ipsum is that the text does not attract attention to
                                itself or distract the viewer's attention from the layout. "</p>
                            <img src="<%= request.getContextPath() %>/assets/images/client/02.jpg"
                                class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                            <ul class="list-unstyled mb-0">
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                            </ul>
                            <h6 class="text-primary">- Carl Oliver <small class="text-muted">P.A</small></h6>
                        </div><!--end customer testi-->

                        <div class="tiny-slide text-center">
                            <p class="text-muted h6 fw-normal fst-italic">" There is now an abundance of readable dummy
                                texts. These are usually used when a text is required purely to fill a space. These
                                alternatives to the classic Lorem Ipsum texts are often amusing and tell short, funny or
                                nonsensical stories. "</p>
                            <img src="<%= request.getContextPath() %>/assets/images/client/03.jpg"
                                class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                            <ul class="list-unstyled mb-0">
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                            </ul>
                            <h6 class="text-primary">- Barbara McIntosh <small class="text-muted">M.D</small></h6>
                        </div><!--end customer testi-->

                        <div class="tiny-slide text-center">
                            <p class="text-muted h6 fw-normal fst-italic">" According to most sources, Lorum Ipsum can
                                be traced back to a text composed by Cicero in 45 BC. Allegedly, a Latin scholar
                                established the origin of the text by compiling all the instances of the unusual word
                                'consectetur' he could find "</p>
                            <img src="<%= request.getContextPath() %>/assets/images/client/04.jpg"
                                class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                            <ul class="list-unstyled mb-0">
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                            </ul>
                            <h6 class="text-primary">- Christa Smith <small class="text-muted">Manager</small></h6>
                        </div><!--end customer testi-->

                        <div class="tiny-slide text-center">
                            <p class="text-muted h6 fw-normal fst-italic">" It seems that only fragments of the original
                                text remain in the Lorem Ipsum texts used today. The most well-known dummy text is the
                                'Lorem Ipsum', which is said to have originated in the 16th century. "</p>
                            <img src="<%= request.getContextPath() %>/assets/images/client/05.jpg"
                                class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                            <ul class="list-unstyled mb-0">
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                            </ul>
                            <h6 class="text-primary">- Dean Tolle <small class="text-muted">Developer</small></h6>
                        </div><!--end customer testi-->

                        <div class="tiny-slide text-center">
                            <p class="text-muted h6 fw-normal fst-italic">" It seems that only fragments of the original
                                text remain in the Lorem Ipsum texts used today. One may speculate that over the course
                                of time certain letters were added or deleted at various positions within the text. "
                            </p>
                            <img src="<%= request.getContextPath() %>/assets/images/client/06.jpg"
                                class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                            <ul class="list-unstyled mb-0">
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                            </ul>
                            <h6 class="text-primary">- Jill Webb <small class="text-muted">Designer</small></h6>
                        </div><!--end customer testi-->
                    </div><!--end carousel-->
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->

        <div class="container mt-100 mt-60">
            <div class="row justify-content-center">
                <div class="col-12">
                    <div class="section-title text-center mb-4 pb-2">
                        <span class="badge badge-pill badge-soft-primary mb-3">Read News</span>
                        <h4 class="title mb-4">Latest News & Blogs</h4>
                        <p class="text-muted mx-auto para-desc mb-0">Great doctor if you need your family member to get
                            effective immediate assistance, emergency treatment or a simple consultation.</p>
                    </div>
                </div><!--end col-->
            </div><!--end row-->

            <div class="row">
                <div class="col-lg-4 col-md-6 col-12 mt-4 pt-2">
                    <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                        <img src="<%= request.getContextPath() %>/assets/images/blog/01.jpg" class="img-fluid" alt="">
                        <div class="card-body p-4">
                            <ul class="list-unstyled mb-2">
                                <li class="list-inline-item text-muted small me-3"><i
                                        class="uil uil-calendar-alt text-dark h6 me-1"></i>20th November, 2020</li>
                                <li class="list-inline-item text-muted small"><i
                                        class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                            </ul>
                            <a href="blog-detail.html" class="text-dark title h5">You can easily connect to doctor and
                                make a treatment</a>
                            <div class="post-meta d-flex justify-content-between mt-3">
                                <ul class="list-unstyled mb-0">
                                    <li class="list-inline-item me-2 mb-0"><a href="#" class="text-muted like"><i
                                                class="mdi mdi-heart-outline me-1"></i>33</a></li>
                                    <li class="list-inline-item"><a href="#" class="text-muted comments"><i
                                                class="mdi mdi-comment-outline me-1"></i>08</a></li>
                                </ul>
                                <a href="blog-detail.html" class="link">Read More <i
                                        class="mdi mdi-chevron-right align-middle"></i></a>
                            </div>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-lg-4 col-md-6 col-12 mt-4 pt-2">
                    <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                        <img src="<%= request.getContextPath() %>/assets/images/blog/02.jpg" class="img-fluid" alt="">
                        <div class="card-body p-4">
                            <ul class="list-unstyled mb-2">
                                <li class="list-inline-item text-muted small me-3"><i
                                        class="uil uil-calendar-alt text-dark h6 me-1"></i>20th November, 2020</li>
                                <li class="list-inline-item text-muted small"><i
                                        class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                            </ul>
                            <a href="blog-detail.html" class="text-dark title h5">Lockdowns lead to fewer people seeking
                                medical care</a>
                            <div class="post-meta d-flex justify-content-between mt-3">
                                <ul class="list-unstyled mb-0">
                                    <li class="list-inline-item me-2 mb-0"><a href="#" class="text-muted like"><i
                                                class="mdi mdi-heart-outline me-1"></i>33</a></li>
                                    <li class="list-inline-item"><a href="#" class="text-muted comments"><i
                                                class="mdi mdi-comment-outline me-1"></i>08</a></li>
                                </ul>
                                <a href="blog-detail.html" class="link">Read More <i
                                        class="mdi mdi-chevron-right align-middle"></i></a>
                            </div>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-lg-4 col-md-6 col-12 mt-4 pt-2">
                    <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                        <img src="<%= request.getContextPath() %>/assets/images/blog/03.jpg" class="img-fluid" alt="">
                        <div class="card-body p-4">
                            <ul class="list-unstyled mb-2">
                                <li class="list-inline-item text-muted small me-3"><i
                                        class="uil uil-calendar-alt text-dark h6 me-1"></i>20th November, 2020</li>
                                <li class="list-inline-item text-muted small"><i
                                        class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                            </ul>
                            <a href="blog-detail.html" class="text-dark title h5">Emergency medicine research course for
                                the doctors</a>
                            <div class="post-meta d-flex justify-content-between mt-3">
                                <ul class="list-unstyled mb-0">
                                    <li class="list-inline-item me-2 mb-0"><a href="#" class="text-muted like"><i
                                                class="mdi mdi-heart-outline me-1"></i>33</a></li>
                                    <li class="list-inline-item"><a href="#" class="text-muted comments"><i
                                                class="mdi mdi-comment-outline me-1"></i>08</a></li>
                                </ul>
                                <a href="blog-detail.html" class="link">Read More <i
                                        class="mdi mdi-chevron-right align-middle"></i></a>
                            </div>
                        </div>
                    </div>
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->
    </section><!--end section-->
    <!-- End -->

    <!-- Partners start -->
    <section class="py-4 bg-light">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                    <img src="<%= request.getContextPath() %>/assets/images/client/amazon.png" class="avatar avatar-client" alt="">
                </div><!--end col-->

                <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                    <img src="<%= request.getContextPath() %>/assets/images/client/google.png" class="avatar avatar-client" alt="">
                </div><!--end col-->

                <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                    <img src="<%= request.getContextPath() %>/assets/images/client/lenovo.png" class="avatar avatar-client" alt="">
                </div><!--end col-->

                <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                    <img src="<%= request.getContextPath() %>/assets/images/client/paypal.png" class="avatar avatar-client" alt="">
                </div><!--end col-->

                <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                    <img src="<%= request.getContextPath() %>/assets/images/client/shopify.png" class="avatar avatar-client" alt="">
                </div><!--end col-->

                <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                    <img src="<%= request.getContextPath() %>/assets/images/client/spotify.png" class="avatar avatar-client" alt="">
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->
    </section><!--end section-->
    <!-- Partners End -->

    <!-- Start -->
    <footer class="bg-footer">
        <div class="container">
            <div class="row">
                <div class="col-xl-5 col-lg-4 mb-0 mb-md-4 pb-0 pb-md-2">
                    <a href="#" class="logo-footer">
                        <img src="<%= request.getContextPath() %>/assets/images/logo-light.png" height="22" alt="">
                    </a>
                    <p class="mt-4 me-xl-5">Great doctor if you need your family member to get effective immediate
                        assistance, emergency treatment or a simple consultation.</p>
                </div><!--end col-->

                <div class="col-xl-7 col-lg-8 col-md-12">
                    <div class="row">
                        <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                            <h5 class="text-light title-dark footer-head">Company</h5>
                            <ul class="list-unstyled footer-list mt-4">
                                <li><a href="aboutus.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i>
                                        About us</a></li>
                                <li><a href="departments.html" class="text-foot"><i
                                            class="mdi mdi-chevron-right me-1"></i> Services</a></li>
                                <li><a href="doctor-team-two.html" class="text-foot"><i
                                            class="mdi mdi-chevron-right me-1"></i> Team</a></li>
                                <li><a href="blog-detail.html" class="text-foot"><i
                                            class="mdi mdi-chevron-right me-1"></i> Project</a></li>
                                <li><a href="blogs.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i>
                                        Blog</a></li>
                                <li><a href="login.jsp" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i>
                                        Login</a></li>
                            </ul>
                        </div><!--end col-->

                        <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                            <h5 class="text-light title-dark footer-head">Departments</h5>
                            <ul class="list-unstyled footer-list mt-4">
                                <li><a href="departments.html" class="text-foot"><i
                                            class="mdi mdi-chevron-right me-1"></i> Eye Care</a></li>
                                <li><a href="departments.html" class="text-foot"><i
                                            class="mdi mdi-chevron-right me-1"></i> Psychotherapy</a></li>
                                <li><a href="departments.html" class="text-foot"><i
                                            class="mdi mdi-chevron-right me-1"></i> Dental Care</a></li>
                                <li><a href="departments.html" class="text-foot"><i
                                            class="mdi mdi-chevron-right me-1"></i> Orthopedic</a></li>
                                <li><a href="departments.html" class="text-foot"><i
                                            class="mdi mdi-chevron-right me-1"></i> Cardiology</a></li>
                                <li><a href="departments.html" class="text-foot"><i
                                            class="mdi mdi-chevron-right me-1"></i> Gynecology</a></li>
                                <li><a href="departments.html" class="text-foot"><i
                                            class="mdi mdi-chevron-right me-1"></i> Neurology</a></li>
                            </ul>
                        </div><!--end col-->

                        <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                            <h5 class="text-light title-dark footer-head">Contact us</h5>
                            <ul class="list-unstyled footer-list mt-4">
                                <li class="d-flex align-items-center">
                                    <i data-feather="mail" class="fea icon-sm text-foot align-middle"></i>
                                    <a href="mailto:contact@example.com" class="text-foot ms-2">contact@example.com</a>
                                </li>

                                <li class="d-flex align-items-center">
                                    <i data-feather="phone" class="fea icon-sm text-foot align-middle"></i>
                                    <a href="tel:+152534-468-854" class="text-foot ms-2">+152 534-468-854</a>
                                </li>

                                <li class="d-flex align-items-center">
                                    <i data-feather="map-pin" class="fea icon-sm text-foot align-middle"></i>
                                    <a href="javascript:void(0)" class="video-play-icon text-foot ms-2">View on Google
                                        map</a>
                                </li>
                            </ul>

                            <ul class="list-unstyled social-icon footer-social mb-0 mt-4">
                                <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="facebook"
                                            class="fea icon-sm fea-social"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="rounded-pill"><i
                                            data-feather="instagram" class="fea icon-sm fea-social"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="twitter"
                                            class="fea icon-sm fea-social"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="linkedin"
                                            class="fea icon-sm fea-social"></i></a></li>
                            </ul><!--end icon-->
                        </div><!--end col-->
                    </div><!--end row-->
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->

        <div class="container mt-5">
            <div class="pt-4 footer-bar">
                <div class="row align-items-center">
                    <div class="col-sm-6">
                        <div class="text-sm-start text-center">
                            <p class="mb-0">
                                <script>document.write(new Date().getFullYear())</script> © Doctris. Design with <i
                                    class="mdi mdi-heart text-danger"></i> by <a href="../../../index.html"
                                    target="_blank" class="text-reset">Shreethemes</a>.
                            </p>
                        </div>
                    </div><!--end col-->

                    <div class="col-sm-6 mt-4 mt-sm-0">
                        <ul class="list-unstyled footer-list text-sm-end text-center mb-0">
                            <li class="list-inline-item"><a href="terms.html" class="text-foot me-2">Terms</a></li>
                            <li class="list-inline-item"><a href="privacy.html" class="text-foot me-2">Privacy</a></li>
                            <li class="list-inline-item"><a href="aboutus.html" class="text-foot me-2">About</a></li>
                            <li class="list-inline-item"><a href="contact.html" class="text-foot me-2">Contact</a></li>
                        </ul>
                    </div><!--end col-->
                </div><!--end row-->
            </div>
        </div><!--end container-->
    </footer><!--end footer-->
    <!-- End -->

    <!-- Back to top -->
    <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i
            data-feather="arrow-up" class="icons"></i></a>
    <!-- Back to top -->

    <!-- Offcanvas Start -->
    <div class="offcanvas bg-white offcanvas-top" tabindex="-1" id="offcanvasTop">
        <div class="offcanvas-body d-flex align-items-center align-items-center">
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="text-center">
                            <h4>Search now.....</h4>
                            <div class="subcribe-form mt-4">
                                <form>
                                    <div class="mb-0">
                                        <input type="text" id="help" name="name" class="border bg-white rounded-pill"
                                            required="" placeholder="Search">
                                        <button type="submit" class="btn btn-pills btn-primary">Search</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </div>
    </div>
    <!-- Offcanvas End -->

    <!-- Offcanvas Start -->
    <div class="offcanvas offcanvas-end bg-white shadow" tabindex="-1" id="offcanvasRight"
        aria-labelledby="offcanvasRightLabel">
        <div class="offcanvas-header p-4 border-bottom">
            <h5 id="offcanvasRightLabel" class="mb-0">
                <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="24" class="light-version" alt="">
                <img src="<%= request.getContextPath() %>/assets/images/logo-light.png" height="24" class="dark-version" alt="">
            </h5>
            <button type="button" class="btn-close d-flex align-items-center text-dark" data-bs-dismiss="offcanvas"
                aria-label="Close"><i class="uil uil-times fs-4"></i></button>
        </div>
        <div class="offcanvas-body p-4 px-md-5">
            <div class="row">
                <div class="col-12">
                    <!-- Style switcher -->
                    <div id="style-switcher">
                        <div>
                            <ul class="text-center list-unstyled mb-0">
                                <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light"
                                        onclick="setTheme('style-rtl')"><img
                                            src="<%= request.getContextPath() %>/assets/images/layouts/landing-light-rtl.png"
                                            class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                            class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light"
                                        onclick="setTheme('style')"><img
                                            src="<%= request.getContextPath() %>/assets/images/layouts/landing-light.png"
                                            class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                            class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark"
                                        onclick="setTheme('style-dark-rtl')"><img
                                            src="<%= request.getContextPath() %>/assets/images/layouts/landing-dark-rtl.png"
                                            class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                            class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark"
                                        onclick="setTheme('style-dark')"><img
                                            src="<%= request.getContextPath() %>/assets/images/layouts/landing-dark.png"
                                            class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                            class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4"
                                        onclick="setTheme('style-dark')"><img
                                            src="<%= request.getContextPath() %>/assets/images/layouts/landing-dark.png"
                                            class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                            class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4"
                                        onclick="setTheme('style')"><img
                                            src="<%= request.getContextPath() %>/assets/images/layouts/landing-light.png"
                                            class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                            class="text-muted mt-2 d-block">Light Version</span></a></li>
                                <li class="d-grid"><a href="../admin/index.html" target="_blank" class="mt-4"><img
                                            src="<%= request.getContextPath() %>/assets/images/layouts/light-dash.png"
                                            class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                            class="text-muted mt-2 d-block">Admin Dashboard</span></a></li>
                            </ul>
                        </div>
                    </div>
                    <!-- end Style switcher -->
                </div><!--end col-->
            </div><!--end row-->
        </div>

        <div class="offcanvas-footer p-4 border-top text-center">
            <ul class="list-unstyled social-icon mb-0">
                <li class="list-inline-item mb-0"><a href="https://1.envato.market/doctris-template" target="_blank"
                        class="rounded"><i class="uil uil-shopping-cart align-middle" title="Buy Now"></i></a></li>
                <li class="list-inline-item mb-0"><a href="https://dribbble.com/shreethemes" target="_blank"
                        class="rounded"><i class="uil uil-dribbble align-middle" title="dribbble"></i></a></li>
                <li class="list-inline-item mb-0"><a href="https://www.facebook.com/shreethemes" target="_blank"
                        class="rounded"><i class="uil uil-facebook-f align-middle" title="facebook"></i></a></li>
                <li class="list-inline-item mb-0"><a href="https://www.instagram.com/shreethemes/" target="_blank"
                        class="rounded"><i class="uil uil-instagram align-middle" title="instagram"></i></a></li>
                <li class="list-inline-item mb-0"><a href="https://twitter.com/shreethemes" target="_blank"
                        class="rounded"><i class="uil uil-twitter align-middle" title="twitter"></i></a></li>
                <li class="list-inline-item mb-0"><a href="mailto:support@shreethemes.in" class="rounded"><i
                            class="uil uil-envelope align-middle" title="email"></i></a></li>
                <li class="list-inline-item mb-0"><a href="../../../index.html" target="_blank" class="rounded"><i
                            class="uil uil-globe align-middle" title="website"></i></a></li>
            </ul><!--end icon-->
        </div>
    </div>
    <!-- Offcanvas End -->

    <!-- MOdal Start -->
    <div class="modal fade" id="watchvideomodal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content video-modal rounded overflow-hidden">
                <!-- <video class="w-100" controls autoplay muted loop>
                        <source src="https://www.w3schools.com/html/mov_bbb.mp4" type="video/mp4">
                    </video> -->
                <!--Browser does not support <video> tag -->
                <!--If you want to use your own video please set your files path-->

                <!-- <div class="ratio ratio-16x9">
                            <iframe src="https://www.youtube.com/embed/jNTZpfXYJa4?rel=0" title="YouTube video" allowfullscreen></iframe>
                        </div> -->
                <!--If you want to use the youtube link please try the above code-->

                <div class="ratio ratio-16x9">
                    <iframe src="https://player.vimeo.com/video/99025203" title="Vimeo video" allowfullscreen></iframe>
                </div>
                <!--If you want to use the Vimeo link please try the above code-->
            </div>
        </div>
    </div>
    <!-- MOdal End -->

    <!-- javascript -->
    <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
    <!-- SLIDER -->
    <script src="<%= request.getContextPath() %>/assets/js/tiny-slider.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/tiny-slider-init.js"></script>
    <!-- Counter -->
    <script src="<%= request.getContextPath() %>/assets/js/counter.init.js"></script>
    <!-- Icons -->
    <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
</body>

</html>