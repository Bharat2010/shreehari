<%@ Page Title="" Language="C#" MasterPageFile="~/majori_6.Master"
    AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SHRJ.Login" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

    <style>
        .register-alert {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 16px;
            margin: 10px 15px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
        }

            .register-alert.success {
                background: #e9f7ef;
                color: #1e7e34;
            }

            .register-alert.error {
                background: #fdecea;
                color: #b02a37;
            }

            .register-alert.warning {
                background: #fff3cd;
                color: #856404;
            }

            .register-alert i {
                font-size: 18px;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div id="main-content" class="main-content">
        <div id="primary" class="content-area">
            <div id="title" class="page-title">
                <div class="section-container">
                    <div class="content-title-heading">
                        <h1 class="text-title-heading">Login / Register
                        </h1>
                    </div>
                    <div class="breadcrumbs">
                        <a href="index.html">Home</a><span class="delimiter"></span>Login / Register
                    </div>
                </div>
            </div>

            <div id="content" class="site-content" role="main">
                <div class="section-padding">
                    <div class="section-container p-l-r">
                        <div class="page-login-register">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-12 sm-m-b-50">
                                    <div class="box-form-login">

    <h2>Login</h2>

    <!-- LOGIN ALERT (below header) -->
    <div id="loginAlert" class="register-alert" style="display:none;">
        <i id="loginAlertIcon" class="fas fa-info-circle"></i>
        <span id="loginAlertText"></span>
    </div>

    <div class="box-content">
        <div class="form-login">

            <!-- ❌ NO <form> TAG -->
            <div class="username">
                <label>Username or email address <span class="required">*</span></label>
                <asp:TextBox ID="txtLoginEmail" runat="server"
                    CssClass="input-text"></asp:TextBox>
            </div>

            <div class="password">
                <label>Password <span class="required">*</span></label>
                <asp:TextBox ID="txtLoginPassword" runat="server"
                    CssClass="input-text"
                    TextMode="Password"></asp:TextBox>
            </div>

            <div class="rememberme-lost">
                <div class="remember-me">
                    <asp:CheckBox ID="chkRemember" runat="server" />
                    <label class="inline">Remember me</label>
                </div>
                <div class="lost-password">
                    <a href="page-forgot-password.html">Lost your password?</a>
                </div>
            </div>

            <div class="button-login">
                <asp:Button ID="btnLogin" runat="server"
                    CssClass="button"
                    Text="Login"
                    OnClick="btnLogin_Click" />
            </div>

        </div>
    </div>
</div>

                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-12">
                                    <%--<div class="box-form-login">
													<h2 class="register">Register</h2>
													<div class="box-content">
														<div class="form-register">
															<div method="post" class="register">
																<div class="email">
																	<label>Email address <span class="required">*</span></label>
																	<input type="email" class="input-text" name="email" value="">
																</div>
																<div class="password">
																	<label>Password <span class="required">*</span></label>
																	<input type="password" class="input-text" name="password">
																</div>
																<div class="button-register">
																	<input type="submit" class="button" name="register" value="Register">
																</div>
															</div>
														</div>
													</div>
												</div>--%>
                                    <div class="box-form-login">
                                        <h2 class="register">Register</h2>

                                        <div id="registerAlert" class="register-alert" style="display: none;">
                                            <i id="registerAlertIcon" class="fas fa-info-circle"></i>
                                            <span id="registerAlertText"></span>
                                        </div>

                                        <div class="box-content">
                                            <div class="form-register">

                                                <div class="email">
                                                    <label>Email address <span class="required">*</span></label>
                                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input-text" TextMode="Email"></asp:TextBox>
                                                </div>

                                                <div class="password">
                                                    <label>Password <span class="required">*</span></label>
                                                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input-text" TextMode="Password"></asp:TextBox>
                                                </div>

                                                <div class="button-register">
                                                    <asp:Button ID="btnRegister" runat="server"
                                                        CssClass="button"
                                                        Text="Register"
                                                        OnClick="btnRegister_Click" />
                                                </div>
                                                <div id="UserSuccess" class="text-center mt-3" style="display: none;">
                                                    <i class="fas fa-check-circle text-success fs-3"></i>
                                                    <span class="text-success ms-2 fw-bold">Register Successfully Completed. Login now..</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- #content -->
        </div>
        <!-- #primary -->
    </div>
    <!-- #main-content -->
    <script>
        function showRegisterAlert(type, message) {
            var alertBox = $('#registerAlert');
            var icon = $('#registerAlertIcon');

            // Reset classes
            alertBox.removeClass('success error warning').addClass(type);

            // Set message
            $('#registerAlertText').text(message);

            // Set icon
            var iconClass =
                type === 'success' ? 'fa-check-circle' :
                    type === 'error' ? 'fa-times-circle' :
                        'fa-exclamation-circle';

            icon.attr('class', 'fas ' + iconClass);

            // Show alert
            alertBox
                .stop(true, true)
                .slideDown(600)
                .delay(8000)   // 🔥 stays visible longer
                .slideUp(600);
        }
    </script>

    <script>
        function showLoginAlert(type, message) {
            var alertBox = $('#loginAlert');
            var icon = $('#loginAlertIcon');

            alertBox.removeClass('success error warning').addClass(type);
            $('#loginAlertText').text(message);

            var iconClass =
                type === 'success' ? 'fa-check-circle' :
                    type === 'error' ? 'fa-times-circle' :
                        'fa-exclamation-circle';

            icon.attr('class', 'fas ' + iconClass);

            alertBox
                .stop(true, true)
                .slideDown(400)
                .delay(5000)
                .slideUp(400);
        }
    </script>



</asp:Content>
