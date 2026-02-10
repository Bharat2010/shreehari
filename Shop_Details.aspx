<%@ Page Title="" Language="C#" MasterPageFile="~/majori_6.Master" AutoEventWireup="true" CodeBehind="Shop_Details.aspx.cs" Inherits="SHRJ.Shop_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .no-product-message {
            display: block;
            text-align: center;
            padding: 40px;
            font-size: 18px;
            color: #999;
        }
    </style>
    <style>
        .purity-selector {
            display: flex;
            gap: 10px;
        }

        .purity-btn {
            padding: 10px 18px;
            border-radius: 999px; /* fully rounded */
            border: 1px solid #d6b25e;
            background: #fff;
            color: #8a6d1f;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.25s ease;
        }

            .purity-btn:hover {
                background: #fff6dc;
                border-color: #c89b3c;
            }

            .purity-btn.active {
                background: linear-gradient(135deg, #c89b3c, #d6b25e);
                color: #3a2a00;
                border-color: #e0a800;
                box-shadow: 0 4px 10px rgba(249, 185, 60, 0.35);
            }

        .tax-note {
            font-size: 12px;
            color: #777;
            margin-left: 6px;
            white-space: nowrap;
        }

        .colors li span.color-1 {
            background-color: #cfcfcf !important;
        }
    </style>

    <style>
        .content-thumbnail-scroll {
            height: 600px; /* SAME as main image */
            overflow: hidden;
        }

        .slick-thumb .img-item {
            height: 80px;
            margin-bottom: 8px;
        }

        .slick-thumb img {
            width: 70px;
            height: 70px;
            cursor: pointer;
        }
    </style>

    <link rel="shortcut icon" type="image/x-icon" href="media/favicon.png">

    <!-- Dependency Styles -->
    <link rel="stylesheet" href="Content/libs/bootstrap/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="Content/libs/feather-font/css/iconfont.css" type="text/css">
    <link rel="stylesheet" href="Content/libs/icomoon-font/css/icomoon.css" type="text/css">
    <link rel="stylesheet" href="Content/libs/font-awesome/css/font-awesome.css" type="text/css">
    <link rel="stylesheet" href="Content/libs/wpbingofont/css/wpbingofont.css" type="text/css">
    <link rel="stylesheet" href="Content/libs/elegant-icons/css/elegant.css" type="text/css">
    <link rel="stylesheet" href="Content/libs/slick/css/slick.css" type="text/css">
    <link rel="stylesheet" href="Content/libs/slick/css/slick-theme.css" type="text/css">
    <link rel="stylesheet" href="Content/libs/mmenu/css/mmenu.min.css" type="text/css">
    <link rel="stylesheet" href="Content/libs/slider/css/jslider.css">

    <!-- Site Stylesheet -->
    <link rel="stylesheet" href="Content/assets/css/app.css" type="text/css">
    <link rel="stylesheet" href="Content/assets/css/responsive.css" type="text/css">

    <!-- Google Web Fonts -->
    <link href="../../../external.html?link=https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&amp;display=swap" rel="stylesheet">
    <link href="../../../external.html?link=https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&amp;display=swap" rel="stylesheet">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="site-main" class="site-main">
        <div id="main-content" class="main-content">
            <div id="primary" class="content-area">
                <div id="title" class="page-title">
                    <div class="section-container">
                        <div class="content-title-heading">
                            <%--<h1 class="text-title-heading">
										Bora Armchair
									</h1>--%>
                            <h1 class="text-title-heading" id="productTitle" runat="server">Loading...</h1>
                        </div>
                        <div class="breadcrumbs">
                            <a href="default.aspx">Home</a><span> / </span>
                            <a href="shop.aspx">Shop</a><span> / </span>
                            <asp:Literal ID="litBreadcrumbCategory" runat="server"></asp:Literal>
                        </div>
                    </div>
                </div>

                <div id="content" class="site-content" role="main">
                    <div class="shop-details zoom" data-product_layout_thumb="scroll" data-zoom_scroll="true" data-zoom_contain_lens="true" data-zoomtype="inner" data-lenssize="200" data-lensshape="square" data-lensborder="" data-bordersize="2" data-bordercolour="#f9b61e" data-popup="false">
                        <div class="product-top-info">
                            <div class="section-padding">
                                <div class="section-container p-l-r">
                                    <div class="row">
                                        <div class="product-images col-lg-7 col-md-12 col-12">
                                            <asp:HiddenField ID="hdnDesignNo" runat="server" />

                                            <div class="row">
                                                <div class="col-md-2">
                                                    <div class="content-thumbnail-scroll">
                                                        <div class="image-thumbnail slick-carousel slick-vertical"
                                                            data-asnavfor=".image-additional"
                                                            data-centermode="true"
                                                            data-focusonselect="true"
                                                            data-columns4="5" data-columns3="4" data-columns2="4" data-columns1="4" data-columns="4"
                                                            data-nav="true" data-vertical="true" data-verticalswiping="true"
                                                            runat="server" id="divThumbs">
                                                            <!-- optional -->

                                                            <asp:Repeater ID="rptThumbnails" runat="server">
                                                                <ItemTemplate>
                                                                    <div class="img-item slick-slide">
                                                                        <span class="img-thumbnail-scroll">
                                                                           <%-- <img width="600" height="600" src='imgHandle.ashx?id=<%# Eval("ID") %>'  />--%>
                                                                            <%--<img width="600" height="600" src='<%# "imgDetails.ashx?img=" + Eval("ID") %>' />--%>
                                                                            <%--<img width="600" height="600"
                                                                                src='ImageHandler.ashx?path=<%# HttpUtility.UrlEncode(Eval("ImagePath").ToString().Replace(@"D:\DesignImages\", "").Replace(@"\", "/")) %>'
                                                                                alt="Thumbnail" />--%>
                                                                            <img width="600" height="600"
                 src='imgHandle.ashx?img=<%# Eval("ID") %>'
                 class="post-image" alt="Thumbnail" />
                                                                        </span>
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:Repeater>

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-10">
                                                    <div class="scroll-image main-image">
                                                        <div class="image-additional slick-carousel"
                                                            data-asnavfor=".image-thumbnail"
                                                            data-fade="true"
                                                            data-columns4="1" data-columns3="1" data-columns2="1" data-columns1="1" data-columns="1"
                                                            data-nav="true">

                                                            <asp:Repeater ID="rptMainImages" runat="server">
                                                                <ItemTemplate>
                                                                    <div class="img-item slick-slide">
                                                                        <img width="600" height="600" src='ImageHandler.ashx?id=<%# Eval("DesignID") %>&type=base' class="post-image" />
                                                                        <%--<img width="900" height="900"
                                                                            src='ImageHandler.ashx?path=<%# HttpUtility.UrlEncode(Eval("ImagePath").ToString().Replace(@"D:\DesignImages\", "").Replace(@"\", "/")) %>'
                                                                            alt="" title="" />--%>
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:Repeater>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                        </div>


                                        <div class="product-info col-lg-5 col-md-12 col-12 ">
                                            <h1 id="infoTitle" runat="server"></h1>

                                            <span class="price">
                                                
                                                <ins><span>
                                                    <asp:Literal ID="litPrice" runat="server"></asp:Literal></span></ins>
                                                <span class="tax-note">(GST extra as applicable)</span>
                                            </span>

                                            <div class="rating">

                                                <div class="variations">
                                                    <table cellspacing="0">
                                                        <tbody>
                                                            <%--<tr>
                                                                <td class="label">Metal</td>
                                                                <td class="attributes">
                                                                    <span><%= metalDisplay %></span>

                                                                </td>
                                                            </tr>--%>
                                                            <tr>
                                                                <td class="label">Purity</td>
                                                                <td class="attributes">


                                                                    <div class="purity-selector">
                                                                        <button type="button" class="purity-btn active" data-purity="9">9K</button>
                                                                        <button type="button" class="purity-btn" data-purity="14">14K</button>
                                                                        <button type="button" class="purity-btn" data-purity="18">18K</button>
                                                                        <button type="button" class="purity-btn" data-purity="22">22K</button>

                                                                        <!-- Hidden field to store selected purity -->
                                                                        <asp:HiddenField ID="hdnPurity" runat="server" Value="18" />
                                                                    </div>

                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td class="label">Color</td>
                                                                <td class="attributes">
                                                                    <ul class="colors">
                                                                        <li><span class="color-1"></span></li>
                                                                        <li><span class="color-2"></span></li>
                                                                        <li><span class="color-3"></span></li>
                                                                    </ul>
                                                                </td>
                                                            </tr>


                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div class="buttons">
                                                    <div class="add-to-cart-wrap">
                                                        <div class="quantity">
                                                            <button type="button" class="plus">+</button>
                                                            <input type="number" class="qty" step="1" min="0" max="" name="quantity" value="1" title="Qty" size="4" placeholder="" inputmode="numeric" autocomplete="off">
                                                            <button type="button" class="minus">-</button>
                                                        </div>
                                                        <div class="btn-add-to-cart">
                                                            <a href="#" tabindex="0">Add to cart</a>
                                                        </div>
                                                    </div>
                                                    <div class="btn-quick-buy" data-title="Wishlist">
                                                        <button class="product-btn">Buy It Now</button>
                                                    </div>
                                                    <div class="btn-wishlist" data-title="Wishlist">
                                                        <button class="product-btn">Add to wishlist</button>
                                                    </div>
                                                    <div class="btn-compare" data-title="Compare">
                                                        <button class="product-btn">Compare</button>
                                                    </div>
                                                </div>
                                                <div class="product-meta">
                                                    <span class="sku-wrapper">SKU: <span class="sku"><%= designNo %></span></span>
                                                    <span class="posted-in">Category: <a href="shop-grid-left.html" rel="tag"><%= rawCategory2 %></a></span>
                                                    <% if (isFeature || isTrending)
                                                        { %>
                                                    <span class="tagged-as">Tags:
                                                        <% if (isFeature)
                                                            { %>
                                                        <a href="#" rel="tag">Hot</a>
                                                        <% } %>

                                                        <% if (isFeature && isTrending)
                                                            { %>, <% } %>

                                                        <% if (isTrending)
                                                            { %>
                                                        <a href="#" rel="tag">Trend</a>
                                                        <% } %>
                                                    </span>
                                                    <% } %>
                                                </div>
                                                <div class="social-share">
                                                    <a href="#" title="Facebook" class="share-facebook" target="_blank"><i class="fa fa-facebook"></i>Facebook</a>
                                                    <a href="#" title="Twitter" class="share-twitter"><i class="fa fa-twitter"></i>Twitter</a>
                                                    <a href="#" title="Pinterest" class="share-pinterest"><i class="fa fa-pinterest"></i>Pinterest</a>
                                                </div>

                                                <div class="description">
                                                    <h3>Free Delivery</h3>
                                                    The final product’s gold, diamond, and stone weights may vary slightly. If the actual weight is less than the mentioned weight, a refund will be issued. If it is higher, the difference will be payable.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="product-tabs">
                            <div class="section-padding">
                                <div class="section-container p-l-r">
                                    <div class="product-tabs-wrap">
                                        <ul class="nav nav-tabs" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link active" data-toggle="tab" href="#description" role="tab">Description</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" data-toggle="tab" href="#additional-information" role="tab">Additional information</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" data-toggle="tab" href="#reviews" role="tab">Reviews (1)</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane fade show active" id="description" role="tabpanel">


                                                <div class="product-tabs-container mt-10 border-t border-gray-200 pt-8">

                                                    <!-- Tab Navigation -->
                                                    <div class="tabs flex border-b border-gray-300 mb-6">
                                                        <button
                                                            class="tab-button px-6 py-4 font-medium text-lg border-b-2 border-transparent hover:border-amber-600 focus:outline-none transition-colors"
                                                            data-tab="description"
                                                            aria-selected="true">
                                                            Description
                                                        </button>
                                                        <button
                                                            class="tab-button px-6 py-4 font-medium text-lg border-b-2 border-transparent hover:border-amber-600 focus:outline-none transition-colors"
                                                            data-tab="details">
                                                            Product Details
                                                        </button>
                                                        <button
                                                            class="tab-button px-6 py-4 font-medium text-lg border-b-2 border-transparent hover:border-amber-600 focus:outline-none transition-colors"
                                                            data-tab="purity">
                                                            Purity Comparison
                                                        </button>
                                                        <button
                                                            class="tab-button px-6 py-4 font-medium text-lg border-b-2 border-transparent hover:border-amber-600 focus:outline-none transition-colors"
                                                            data-tab="care">
                                                            Care & Notes
                                                        </button>
                                                    </div>


                                                    <div class="tab-content">


                                                        <div class="tab-panel prose prose-amber max-w-none">
                                                            <h3 class="text-2xl font-serif mb-4"><%= designNo %></h3>
                                                            <p class="text-gray-700 leading-relaxed mb-6">
                                                                This exquisite <b><%= metalDisplay %></b> piece from our <%= Collection %> collection embodies timeless elegance and modern sophistication. 
        Perfect for <b><%= Occasion %></b> or as a cherished everyday luxury, it features delicately handcrafted details and sparkling <b><%= DmdPcs %></b> diamonds totaling <b><%= DmdWtCts %> CT</b> carats.
                                                            </p>

                                                            <ul class="list-disc pl-6 space-y-2 text-gray-700">
                                                                <li>Ideal for <b><%= Gender %></b> wear • <b><%= Style %></b> inspired design</li>
                                                                <li>From our prestigious <b><%= Category %> > <%= Subcatgory %> </b>range</li>
                                                                <li>Made with passion for those who appreciate fine craftsmanship</li>
                                                            </ul>

                                                            <p class="mt-6 italic text-gray-600">
                                                                "A piece that tells your story – subtle yet unforgettable."
                                                            </p>
                                                        </div>


                                                        <div id="details" class="tab-panel hidden">
                                                            <h3 class="text-2xl font-serif mb-6">Product Specifications</h3>

                                                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                                                <div>
                                                                    <div class="space-y-4">
                                                                        <div>
                                                                            <div class="text-sm font-medium text-gray-500"><b>Metal</b></div>
                                                                            <div class="text-base"><%= Metalfull %></div>
                                                                        </div>
                                                                        <div>
                                                                            <div class="text-sm font-medium text-gray-500"><b>Metal Weight</b></div>
                                                                            <div class="text-base"><%= MetalWtGms %> g</div>
                                                                        </div>
                                                                        <div>
                                                                            <div class="text-sm font-medium text-gray-500"><b>Gross Weight</b></div>
                                                                            <div class="text-base"><%= GrossWtGms %> g</div>
                                                                        </div>
                                                                        <div>
                                                                            <div class="text-sm font-medium text-gray-500"><b>Diamond</b></div>
                                                                            <div class="text-base"><%= DmdWtCts %> ct (<%= DmdPcs %> pieces)</div>
                                                                        </div>
                                                                        <div>
                                                                            <div class="text-sm font-medium text-gray-500"><b>Color Stones</b></div>
                                                                            <div class="text-base"><%= CTNWtCts %> ct (<%= CTNPcs %> pieces)</div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div>
                                                                    <div class="space-y-4">
                                                                        <div>
                                                                            <div class="text-sm font-medium text-gray-500"><b>Making Charge</b></div>
                                                                            <div class="text-base">
                                                                                ₹<%= MakingChargePrGM %>/g 
                                                                                    (₹<%
                                                                                          decimal val = 0m;
                                                                                          decimal.TryParse(MakingChargeRs, out val);
                                                                                    %><%= val.ToString("N2") %> total)
                                                                            </div>
                                                                        </div>
                                                                        <div>

                                                                            <div class="text-sm font-medium text-gray-500"><b>GST</b></div>
                                                                            <div class="text-base">
                                                                                <%= GSTRate %>%
                                                                                    (₹<span id="gstAmountDisplay">
                                                                                        <%
                                                                                            decimal amt = 0m;
                                                                                            if (!decimal.TryParse(GSTAmount ?? "0", out amt))
                                                                                            {
                                                                                                amt = 0m;
                                                                                            }
                                                                                        %>
                                                                                        <%= amt.ToString("N0") %>
                                                                                    </span>)
                                                                            </div>
                                                                        </div>
                                                                        <div>
                                                                            <div class="text-sm font-medium text-gray-500"><b>Courier</b></div>
                                                                            <div class="text-base">
                                                                                <%
                                                                                    decimal courierAmt = 0m;
                                                                                    decimal.TryParse(Courier ?? "0", out courierAmt);
                                                                                %>
                                                                                    ₹<%= courierAmt.ToString("N2") %>
                                                                            </div>
                                                                        </div>
                                                                        <div class="pt-4 border-t">
                                                                            <div class="text-lg font-semibold text-amber-800"><b>Final Price</b></div>
                                                                            <div class="text-2xl font-bold text-amber-900">
                                                                                ₹<span id="finalPriceNumber">
                                                                                    <%
                                                                                        decimal finalAmt;
                                                                                        decimal.TryParse(FinalAmount ?? "0", out finalAmt);
                                                                                    %>
                                                                                    <%= finalAmt.ToString("N0") %>
                                                                                </span>
                                                                            </div>
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!-- Purity Comparison Tab (your view's killer feature) -->
                                                        <%--  <div id="purity" class="tab-panel hidden">
      <h3 class="text-2xl font-serif mb-6">Gold Value Comparison (Metal only)</h3>
      <p class="text-gray-600 mb-6">Same design — different purity options (prices shown for gold value only, excluding stones & making):</p>
      
      <div class="grid grid-cols-2 sm:grid-cols-4 gap-6">
        <div class="bg-amber-50 p-6 rounded-xl text-center border border-amber-200">
          <h4 class="text-lg font-semibold mb-2">9 KT</h4>
          <p class="text-2xl font-bold text-amber-800">₹{GoldValue_9KT_Rs}</p>
        </div>
        <div class="bg-amber-50 p-6 rounded-xl text-center border border-amber-200">
          <h4 class="text-lg font-semibold mb-2">14 KT</h4>
          <p class="text-2xl font-bold text-amber-800">₹{GoldValue_14KT_Rs}</p>
        </div>
        <div class="bg-amber-50 p-6 rounded-xl text-center border border-amber-200">
          <h4 class="text-lg font-semibold mb-2">18 KT</h4>
          <p class="text-2xl font-bold text-amber-800">₹{GoldValue_18KT_Rs}</p>
        </div>
        <div class="bg-amber-50 p-6 rounded-xl text-center border border-amber-200 highlight">
          <h4 class="text-lg font-semibold mb-2">22 KT</h4>
          <p class="text-2xl font-bold text-amber-900">₹{GoldValue_22KT_Rs}</p>
        </div>
      </div>
      
      <p class="mt-8 text-sm text-gray-500 italic">
        Note: Actual price uses {MetalFull} purity. Higher purity = higher gold value but may affect making charges & look.
      </p>
    </div>--%>

                                                        <!-- Care Tab (static or short) -->
                                                        <div id="care" class="tab-panel hidden prose max-w-none">
                                                            <h3 class="text-2xl font-serif mb-4">Care Instructions</h3>
                                                            <ul class="list-disc pl-6 space-y-2">
                                                                <li>Store in a soft pouch away from direct sunlight</li>
                                                                <li>Avoid contact with chemicals, perfumes & lotions</li>
                                                                <li>Clean gently with lukewarm soapy water & soft brush</li>
                                                                <li>Professional cleaning recommended every 6 months</li>
                                                            </ul>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="additional-information" role="tabpanel">

                                                <%--<table class="product-attributes">
                                                    <tbody>
                                                        <tr class="attribute-item">
                                                            <th class="attribute-label">Color</th>
                                                            <td class="attribute-value">Antique, Chestnut, Grullo</td>
                                                        </tr>
                                                    </tbody>
                                                </table>--%>

                                                <div class="tab-pane fade show active" id="diamond-information" role="tabpanel">
                                                    <h3 class="section-title">Diamond Details</h3>
                                                    <asp:GridView ID="gvDiamondDetails" runat="server"
                                                        AutoGenerateColumns="false"
                                                        CssClass="gem-grid table table-bordered"
                                                        AllowSorting="True"
                                                        EmptyDataText="No diamond details found for this design.">

                                                        <Columns>

                                                            <asp:BoundField DataField="ShapeName" HeaderText="Shape" />
                                                            <asp:BoundField DataField="DiamondWeight" HeaderText="Carat" DataFormatString="{0:F2}" />
                                                            <asp:BoundField DataField="ColorName" HeaderText="Color" />
                                                            <asp:BoundField DataField="ClarityName" HeaderText="Clarity" />
                                                            <asp:BoundField DataField="NumberOfPieces" HeaderText="Pcs" />

                                                        </Columns>
                                                    </asp:GridView>
                                                </div>


                                                <div class="tab-pane fade show active" id="colorstone-information" role="tabpanel">
                                                    <h3 class="section-title">Colorstone Details</h3>
                                                    <asp:GridView ID="gridColorstone" runat="server"
                                                        AutoGenerateColumns="false"
                                                        CssClass="gem-grid table table-bordered"
                                                        AllowSorting="True"
                                                        EmptyDataText="No diamond details found for this design.">

                                                        <Columns>

                                                            <asp:BoundField DataField="ColorstoneTypeName" HeaderText="Type" />
                                                            <asp:BoundField DataField="ColorstoneWeight" HeaderText="Carat" DataFormatString="{0:F2}" />
                                                            <asp:BoundField DataField="ShapeName" HeaderText="Shape" />
                                                            <asp:BoundField DataField="ColorName" HeaderText="Clarity" />
                                                            <asp:BoundField DataField="NumberOfPieces" HeaderText="Pcs" />

                                                        </Columns>
                                                    </asp:GridView>
                                                </div>


                                            </div>
                                            <div class="tab-pane fade" id="reviews" role="tabpanel">
                                                <div id="reviews1" class="product-reviews">
                                                    <div id="comments">
                                                        <h2 class="reviews-title">1 review for <span>Bora Armchair</span></h2>
                                                        <ol class="comment-list">
                                                            <li class="review">
                                                                <div class="content-comment-container">
                                                                    <div class="comment-container">
                                                                        <img src="media/user.jpg" class="avatar" height="60" width="60" alt="">
                                                                        <div class="comment-text">
                                                                            <div class="rating small">
                                                                                <div class="star star-5"></div>
                                                                            </div>
                                                                            <div class="review-author">Peter Capidal</div>
                                                                            <div class="review-time">January 12, 2023</div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="description">
                                                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam fringilla augue nec est tristique auctor. Donec non est at libero vulputate rutrum. Morbi ornare lectus quis justo gravida semper. Nulla tellus mi, vulputate adipiscing cursus eu, suscipit id nulla.</p>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        </ol>
                                                    </div>
                                                    <div id="review-form">
                                                        <div id="respond" class="comment-respond">
                                                            <span id="reply-title" class="comment-reply-title">Add a review</span>
                                                            <div action="#" method="post" id="comment-form" class="comment-form">
                                                                <p class="comment-notes">
                                                                    <span id="email-notes">Your email address will not be published.</span> Required fields are marked <span class="required">*</span>
                                                                </p>
                                                                <div class="comment-form-rating">
                                                                    <label for="rating">Your rating</label>
                                                                    <p class="stars">
                                                                        <span>
                                                                            <a class="star-1" href="#">1</a><a class="star-2" href="#">2</a><a class="star-3" href="#">3</a><a class="star-4" href="#">4</a><a class="star-5" href="#">5</a>
                                                                        </span>
                                                                    </p>
                                                                </div>
                                                                <p class="comment-form-comment">
                                                                    <textarea id="comment" name="comment" placeholder="Your Reviews *" cols="45" rows="8" aria-required="true" required=""></textarea>
                                                                </p>
                                                                <div class="content-info-reviews">
                                                                    <p class="comment-form-author">
                                                                        <input id="author" name="author" placeholder="Name *" type="text" value="" size="30" aria-required="true" required="">
                                                                    </p>
                                                                    <p class="comment-form-email">
                                                                        <input id="email" name="email" placeholder="Email *" type="email" value="" size="30" aria-required="true" required="">
                                                                    </p>
                                                                    <p class="form-submit">
                                                                        <input name="submit" type="submit" id="submit" class="submit" value="Submit">
                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <!-- #respond -->
                                                        </div>
                                                    </div>
                                                    <div class="clear"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="product-related">
                            <div class="section-padding">
                                <div class="section-container p-l-r">
                                    <div class="block block-products slider">
                                        <div class="block-title">
                                            <h2>Related Products</h2>
                                        </div>
                                        <div class="block-content">
                                            <div class="content-product-list slick-wrap">
                                                <div class="slick-sliders products-list grid" data-slidestoscroll="true" data-dots="false" data-nav="1" data-columns4="1" data-columns3="2" data-columns2="3" data-columns1="3" data-columns1440="4" data-columns="4">
                                                    <%--<div class="item-product slick-slide">
                                                        <div class="items">
                                                            <div class="products-entry clearfix product-wapper">
                                                                <div class="products-thumb">
                                                                    <div class="product-lable">
                                                                        <div class="hot">Hot</div>
                                                                    </div>
                                                                    <div class="product-thumb-hover">
                                                                        <a href="shop-details.html">
                                                                            <img width="600" height="600" src="media/product/13.jpg" class="post-image" alt="">
                                                                            <img width="600" height="600" src="media/product/13-2.jpg" class="hover-image back" alt="">
                                                                        </a>
                                                                    </div>
                                                                    <div class="product-button">
                                                                        <div class="btn-add-to-cart" data-title="Add to cart">
                                                                            <a rel="nofollow" href="#" class="product-btn button">Add to cart</a>
                                                                        </div>
                                                                        <div class="btn-wishlist" data-title="Wishlist">
                                                                            <button class="product-btn">Add to wishlist</button>
                                                                        </div>
                                                                        <div class="btn-compare" data-title="Compare">
                                                                            <button class="product-btn">Compare</button>
                                                                        </div>
                                                                        <span class="product-quickview" data-title="Quick View">
                                                                            <a href="#" class="quickview quickview-button">Quick View <i class="icon-search"></i></a>
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                                <div class="products-content">
                                                                    <div class="contents text-center">
                                                                        <h3 class="product-title"><a href="shop-details.html">Medium Flat Hoops</a></h3>
                                                                        <div class="rating">
                                                                            <div class="star star-5"></div>
                                                                        </div>
                                                                        <span class="price">$100.00</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>--%>

                                                    <asp:Repeater ID="rptProducts" runat="server">
                                                        <ItemTemplate>

                                                            <div class="item-product slick-slide">
                                                                <div class="items">
                                                                    <div class="products-entry clearfix product-wapper">

                                                                        <div class="products-thumb">
                                                                            <%# (Convert.ToBoolean(Eval("IsTrending")) || Convert.ToBoolean(Eval("IsFeatured"))) ? "<div class=\"product-lable\"><div class=\"hot\">Trending</div></div>" : "" %>

                                                                            <div class="product-thumb-hover">
                                                                                <a href='<%# "shop_details.aspx?DesignNo=" + Eval("DesignNo") %>'
                                                                                    class="design-link"
                                                                                    target="_blank"
                                                                                    rel="noopener noreferrer">
                                                                                    <%-- <a href='<%# "tst.aspx?DesignNo=" + Eval("DesignNo") %>'>--%>
                                                                                    <img width="600" height="600" src='ImageHandler.ashx?id=<%# Eval("DesignID") %>&type=base' class="post-image" />
                                                                                    <img width="600" height="600" src='ImageHandler.ashx?id=<%# Eval("DesignID") %>&type=hover' class="hover-image back" />
                                                                                </a>
                                                                            </div>
                                                                            <%-- BUTTONS --%>
                                                                            <div class="product-button">
                                                                                <div class="btn-add-to-cart">
                                                                                    <a href="#" class="product-btn button">Add to cart</a>
                                                                                </div>
                                                                                <div class="btn-wishlist">
                                                                                    <button class="product-btn">Wishlist</button>
                                                                                </div>
                                                                                <div class="btn-compare">
                                                                                    <button class="product-btn">Compare</button>
                                                                                </div>
                                                                            </div>

                                                                        </div>

                                                                        <%-- CONTENT --%>
                                                                        <div class="products-content">
                                                                            <div class="contents text-center">
                                                                                <h3 class="product-title">
                                                                                    <a href='shop-details.aspx?DesignNo=<%# Eval("DesignNo") %>'>
                                                                                        <%# Eval("DesignName") %>
                                                                                    </a>
                                                                                </h3>

                                                                                <span class="price">₹ <%# String.Format("{0:N0}", Eval("FinalPrice_18KT")) %>
                                                                                </span>
                                                                            </div>
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                    <asp:Label ID="lblNoProducts" runat="server"
                                                        Text="No product found"
                                                        CssClass="no-product-message"
                                                        Visible="false" />
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
    </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="Content/libs/popper/js/popper.min.js"></script>
    <script src="Content/libs/jquery/js/jquery.min.js"></script>
    <script src="Content/libs/bootstrap/js/bootstrap.min.js"></script>
    <script src="Content/libs/slick/js/slick.min.js"></script>
    <script src="Content/libs/mmenu/js/jquery.mmenu.all.min.js"></script>
    <script src="Content/libs/slider/js/tmpl.js"></script>
    <script src="Content/libs/slider/js/jquery.dependClass-0.1.js"></script>
    <script src="Content/libs/slider/js/draggable-0.1.js"></script>
    <script src="Content/libs/slider/js/jquery.slider.js"></script>
    <script src="Content/libs/elevatezoom/js/jquery.elevatezoom.js"></script>

    <!-- Site Scripts -->
    <script src="Content/assets/js/app.js"></script>

    <script>
        fetch('/imgDetails.ashx?id=10')
            .then(res => res.json())
            .then(images => {
                images.forEach(url => {
                    document.getElementById('gallery').innerHTML +=
                        `<img src="${url}" style="width:150px;margin:5px;" />`;
                });
            });

        $('.image-thumbnail-scroll').slick({
            vertical: true,
            slidesToShow: 4,
            asNavFor: '.image-additional',
            focusOnSelect: true
        });

        $('.image-additional').slick({
            slidesToShow: 1,
            fade: true,
            asNavFor: '.image-thumbnail-scroll'
        });

    </script>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const buttons = document.querySelectorAll('.tab-button');
            const panels = document.querySelectorAll('.tab-panel');

            buttons.forEach(btn => {
                btn.addEventListener('click', () => {
                    // Remove active styles
                    buttons.forEach(b => {
                        b.classList.remove('border-amber-600', 'text-amber-800');
                        b.classList.add('border-transparent', 'text-gray-600');
                    });
                    panels.forEach(p => p.classList.add('hidden'));

                    // Activate clicked
                    btn.classList.remove('border-transparent', 'text-gray-600');
                    btn.classList.add('border-amber-600', 'text-amber-800');
                    document.getElementById(btn.dataset.tab).classList.remove('hidden');
                });
            });
        });
    </script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {

            var selectedPurity = document.getElementById('<%= hdnPurity.ClientID %>').value;

            document.querySelectorAll(".purity-btn").forEach(function (btn) {
                btn.classList.remove("active");

                if (btn.dataset.purity === selectedPurity) {
                    btn.classList.add("active");
                }


                btn.addEventListener("click", function () {
                    document.querySelectorAll(".purity-btn").forEach(b => b.classList.remove("active"));
                    this.classList.add("active");
                    document.getElementById('<%= hdnPurity.ClientID %>').value = this.dataset.purity;
                });
            });
        });
    </script>


    <script type="text/javascript">
        $(document).ready(function () {

            const designNo = $('#<%= hdnDesignNo.ClientID %>').val()?.trim();

            if (!designNo) {
                console.warn("Design number is missing → price update disabled");
                return;
            }


            const currentPurity = $('#<%= hdnPurity.ClientID %>').val() || "18";
            $('.purity-btn').removeClass('active');
            $(`.purity-btn[data-purity="${currentPurity}"]`).addClass('active');


            $('.purity-btn').on('click', function () {

                const newPurity = $(this).data('purity');   // "9", "14", "18", "22"


                $('.purity-btn').removeClass('active');
                $(this).addClass('active');
                $('#<%= hdnPurity.ClientID %>').val(newPurity);


                $.ajax({
                    type: "POST",
                    url: "Shop_Details.aspx/GetFinalPriceByPurity",
                    data: JSON.stringify({ designNo: designNo, purity: newPurity }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",


                    success: function (response) {
                        console.log("AJAX Raw Response:", response);

                        let result = response.d || response;

                        if (!result || result.success !== true) {
                            console.warn("Invalid / failed response:", result);
                            return;
                        }

                        // ────────────────────────────────────────────────
                        // Base price (the one near "Add to cart" area)
                        // ────────────────────────────────────────────────
                        const basePrice = Number(result.basePrice || 0);
                        const baseFormatted = "₹" + basePrice.toLocaleString('en-IN', {
                            minimumFractionDigits: 0,
                            maximumFractionDigits: 0
                        });

                        const $mainPrice = $('#<%= litPrice.ClientID %>');
                            if ($mainPrice.length === 1) {
                                $mainPrice.text(baseFormatted);
                                console.log("Main price (litPrice) updated →", baseFormatted);
                            } else {
                                console.warn("Main price selector not found");
                                // Optional fallback if litPrice still fails
                                $('ins span').filter(function () { return $(this).text().includes('₹'); }).text(baseFormatted);
                            }
                            // ────────────────────────────────────────────────
                            // Update GST amount (if returned by server)
                            // ────────────────────────────────────────────────
                            if (result.gstAmount !== undefined) {
                                const gstFormatted = Number(result.gstAmount).toLocaleString('en-IN', {
                                    minimumFractionDigits: 0,
                                    maximumFractionDigits: 0
                                });

                                const $gst = $('#gstAmountDisplay');
                                if ($gst.length === 1) {
                                    $gst.text(gstFormatted);
                                    console.log("GST amount updated → ₹" + gstFormatted);
                                } else {
                                    console.warn("GST display element #gstAmountDisplay not found");
                                }
                            }
                            // ────────────────────────────────────────────────
                            // Final price (with GST + courier)
                            // ────────────────────────────────────────────────
                            const finalPrice = Number(result.finalPrice || 0);
                            const finalFormatted = "₹" + finalPrice.toLocaleString('en-IN', {
                                minimumFractionDigits: 0,
                                maximumFractionDigits: 0
                            });

                            const $finalNumber = $('#finalPriceNumber');
                            if ($finalNumber.length === 1) {
                                $finalNumber.text(finalFormatted.replace('₹', ''));  // remove ₹ because it's already outside span
                                console.log("Final price updated →", finalFormatted);
                            } else {
                                console.warn("FINAL PRICE ELEMENT NOT FOUND → #finalPriceNumber length = 0");
                                console.log("Looking for elements containing ₹...");
                                // Emergency debug: list candidates
                                $("*").filter(function () {
                                    return $(this).text().includes('₹') && $(this).text().length < 30;
                                }).each(function (i) {
                                    console.log(`Candidate ${i + 1}:`, this.tagName, this.id, $(this).text().trim());
                                });
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("Price AJAX failed:", status, error);
                            console.log("Response:", xhr.responseText);

                        }
                    });
            });
        });
    </script>

    <script>
        function initDesignSliders() {

            if ($('.slick-main').hasClass('slick-initialized')) {
                $('.slick-main').slick('unslick');
                $('.slick-thumb').slick('unslick');
            }

            $('.slick-main').slick({
                slidesToShow: 1,
                slidesToScroll: 1,
                arrows: false,
                fade: true,
                asNavFor: '.slick-thumb'
            });

            $('.slick-thumb').slick({
                slidesToShow: 5,
                slidesToScroll: 1,
                asNavFor: '.slick-main',
                vertical: true,
                verticalSwiping: true,
                focusOnSelect: true,
                arrows: true,
                infinite: false
            });
        }

        Sys.Application.add_load(initDesignSliders); // IMPORTANT for WebForms
    </script>
</asp:Content>
