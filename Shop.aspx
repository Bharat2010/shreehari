<%@ Page Title="" Language="C#" MasterPageFile="~/majori_6.Master" AutoEventWireup="true" CodeBehind="Shop.aspx.cs" Inherits="SHRJ.Shop" %>

<%@ Register TagPrefix="asp" Namespace="System.Web.UI.WebControls" Assembly="System.Web" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="site-main" class="site-main">
        <div id="main-content" class="main-content">
            <div id="primary" class="content-area">
                <div id="title" class="page-title">
                    <div class="section-container">
                        <div class="content-title-heading">
                            <h1 class="text-title-heading">
                                <asp:Literal ID="litPageTitle" runat="server" Text="Shop" />
                            </h1>
                        </div>
                        <div class="breadcrumbs">

                            <a href="index.aspx">Home</a>
                            <span class="delimiter"></span>
                            <a href="Products.aspx">Shop</a>
                            <span class="delimiter"></span>
                            <asp:Literal ID="litCurrentCategory" runat="server" Text="All Products" />
                        </div>

                    </div>
                </div>

                <div id="content" class="site-content" role="main">
                    <div class="section-padding">
                        <div class="section-container p-l-r">
                            <div class="row">
                                <div class="col-xl-12 col-lg-12 col-md-12 col-12">
                                    <div class="products-topbar clearfix">
                                        <div class="products-topbar-left">
                                            <div class="products-count">
                                                <asp:Literal ID="litResultsCount" runat="server" Text="Showing all 0 results" />
                                            </div>
                                        </div>
                                        <div class="products-topbar-right">
                                            <!-- Sorting Dropdown (Original - Exactly as it was) -->
                                            <div class="products-sort dropdown">
                                                <a class="sort-toggle dropdown-toggle"
                                                    href="#"
                                                    role="button"
                                                    data-toggle="dropdown"
                                                    aria-haspopup="true"
                                                    aria-expanded="false">
                                                    <asp:Literal ID="litCurrentSort" runat="server" Text="Default sorting" />
                                                    <span class="caret"></span>
                                                </a>
                                                <ul class="sort-list dropdown-menu">
                                                    <li><a href="<%= GetSortUrl("default") %>" <%= CurrentSort == "default" ? "class=\"active\"" : "" %>>Default sorting</a></li>
                                                    <li><a href="<%= GetSortUrl("popularity") %>" <%= CurrentSort == "popularity" ? "class=\"active\"" : "" %>>Sort by popularity</a></li>
                                                    <li><a href="<%= GetSortUrl("latest") %>" <%= CurrentSort == "latest" ? "class=\"active\"" : "" %>>Sort by latest</a></li>
                                                    <li><a href="<%= GetSortUrl("price_low") %>" <%= CurrentSort == "price_low" ? "class=\"active\"" : "" %>>Sort by price: low to high</a></li>
                                                    <li><a href="<%= GetSortUrl("price_high") %>" <%= CurrentSort == "price_high" ? "class=\"active\"" : "" %>>Sort by price: high to low</a></li>
                                                </ul>
                                            </div>
                                            <!-- Grid / List Layout Toggle (Original) -->
                                            <ul class="layout-toggle nav nav-tabs">
                                                <li class="nav-item">
                                                    <a class="layout-grid nav-link active" data-toggle="tab" href="#layout-grid" role="tab">
                                                        <span class="icon-column">
                                                            <span class="layer first"><span></span><span></span><span></span></span>
                                                            <span class="layer middle"><span></span><span></span><span></span></span>
                                                            <span class="layer last"><span></span><span></span><span></span></span>
                                                        </span>
                                                    </a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="layout-list nav-link" data-toggle="tab" href="#layout-list" role="tab">
                                                        <span class="icon-column">
                                                            <span class="layer first"><span></span><span></span></span>
                                                            <span class="layer middle"><span></span><span></span></span>
                                                            <span class="layer last"><span></span><span></span></span>
                                                        </span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="tab-content">
                                        <div class="tab-pane fade show active" id="layout-grid" role="tabpanel">
                                            <div class="products-list grid">
                                                <div class="row">
                                                    <%--<div class="col-xl-3 col-lg-4 col-md-4 col-sm-6">
																<div class="products-entry clearfix product-wapper">
																	<div class="products-thumb">
																		<div class="product-lable">
																			<div class="hot">Hot</div>
																		</div>
																		<div class="product-thumb-hover">
																			<a href="shop-details.html">
																				<img width="600" height="600" src="media/product/1.jpg" class="post-image" alt="">
																				<img width="600" height="600" src="media/product/1-2.jpg" class="hover-image back" alt="">
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
																			<div class="rating">
																				<div class="star star-0"></div><span class="count">(0 review)</span>
																			</div>
																			<h3 class="product-title"><a href="shop-details.html">Medium Flat Hoops</a></h3>
																			<span class="price">$150.00</span>
																		</div>
																	</div>
																</div>
															</div>
															<div class="col-xl-3 col-lg-4 col-md-4 col-sm-6">
																<div class="products-entry clearfix product-wapper">
																	<div class="products-thumb">
																		<div class="product-lable">
																			<div class="onsale">-33%</div>
																		</div>
																		<div class="product-thumb-hover border">
																			<a href="shop-details.html">
																				<img width="600" height="600" src="media/product/5.jpg" class="post-image" alt="">
																				<img width="600" height="600" src="media/product/5-2.jpg" class="hover-image back" alt="">
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
																			<div class="rating">
																				<div class="star star-5"></div><span class="count">(1 review)</span>
																			</div>
																			<h3 class="product-title"><a href="shop-details.html">Yilver And Turquoise Earrings</a></h3>
																			<span class="price">
																				<del aria-hidden="true"><span>$150.00</span></del> 
																				<ins><span>$100.00</span></ins>
																			</span>
																		</div>
																	</div>
																</div>
															</div>
													--%>


                                                    <asp:Repeater ID="rptProductsGrid" runat="server">
                                                        <ItemTemplate>
                                                            <div class="col-xl-3 col-lg-4 col-md-4 col-sm-6 col-6">
                                                                <div class="products-entry clearfix product-wapper">
                                                                    <div class="products-thumb border">
                                                                        <%--<%# Convert.ToBoolean(Eval("IsOnSale")) ? "<div class=\"product-lable\"><div class=\"onsale\">-" + CalculateDiscount(Eval("ProductValue_Rs"), Eval("Price")) + "%</div></div>" : "" %>--%>
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
                                                                            <h3 class="product-title">
                                                                                <a href='<%# "shop-details.aspx?DesignNo=" + Eval("DesignNo") %>'><%# Eval("DesignName") %></a>
                                                                            </h3>
                                                                            <span class="price">
                                                                                <%# (Convert.ToBoolean(Eval("IsOnSale")) && Convert.ToDecimal(Eval("ProductValue_Rs")) > Convert.ToDecimal(Eval("ProductValue_Rs")))
                    ? String.Format("<del>₹{0:N2}</del> <ins>₹{1:N2}</ins>", Eval("ProductValue_Rs"), Eval("ProductValue_Rs"))
                    : String.Format("₹{0:N2}", Eval("ProductValue_Rs")) %>
                                                                            </span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-pane fade" id="layout-list" role="tabpanel">
                                            <div class="products-list list">
                                                <div class="products-entry clearfix product-wapper">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="products-thumb">
                                                                <div class="product-lable">
                                                                    <div class="hot">Hot</div>
                                                                </div>
                                                                <div class="product-thumb-hover">
                                                                    <a href="shop-details.html">
                                                                        <img width="600" height="600" src="media/product/1.jpg" class="post-image" alt="">
                                                                        <img width="600" height="600" src="media/product/1-2.jpg" class="hover-image back" alt="">
                                                                    </a>
                                                                </div>
                                                                <span class="product-quickview" data-title="Quick View">
                                                                    <a href="#" class="quickview quickview-button">Quick View <i class="icon-search"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <div class="products-content">
                                                                <h3 class="product-title"><a href="shop-details.html">Medium Flat Hoops</a></h3>
                                                                <span class="price">$150.00</span>
                                                                <div class="rating">
                                                                    <div class="star star-5"></div>
                                                                    <div class="review-count">
                                                                        (1<span> review</span>)
																		
                                                                    </div>
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
                                                                </div>
                                                                <div class="product-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis…</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="products-entry clearfix product-wapper">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="products-thumb">
                                                                <div class="product-lable">
                                                                    <div class="hot">Hot</div>
                                                                </div>
                                                                <div class="product-thumb-hover border">
                                                                    <a href="shop-details.html">
                                                                        <img width="600" height="600" src="media/product/5.jpg" class="post-image" alt="">
                                                                        <img width="600" height="600" src="media/product/5-2.jpg" class="hover-image back" alt="">
                                                                    </a>
                                                                </div>
                                                                <span class="product-quickview" data-title="Quick View">
                                                                    <a href="#" class="quickview quickview-button">Quick View <i class="icon-search"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <div class="products-content">
                                                                <h3 class="product-title"><a href="shop-details.html">Yilver And Turquoise Earrings</a></h3>
                                                                <span class="price">
                                                                    <del aria-hidden="true"><span>$150.00</span></del>
                                                                    <ins><span>$100.00</span></ins>
                                                                </span>
                                                                <div class="rating">
                                                                    <div class="star star-0"></div>
                                                                    <div class="review-count">
                                                                        (0<span> review</span>)
																		
                                                                    </div>
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
                                                                </div>
                                                                <div class="product-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis…</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="products-entry clearfix product-wapper">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="products-thumb">
                                                                <div class="product-lable">
                                                                    <div class="hot">Hot</div>
                                                                </div>
                                                                <div class="product-thumb-hover">
                                                                    <a href="shop-details.html">
                                                                        <img width="600" height="600" src="media/product/2.jpg" class="post-image" alt="">
                                                                        <img width="600" height="600" src="media/product/2-2.jpg" class="hover-image back" alt="">
                                                                    </a>
                                                                </div>
                                                                <span class="product-quickview" data-title="Quick View">
                                                                    <a href="#" class="quickview quickview-button">Quick View <i class="icon-search"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <div class="products-content">
                                                                <h3 class="product-title"><a href="shop-details.html">Bold Pearl Hoop Earrings</a></h3>
                                                                <span class="price">$150.00</span>
                                                                <div class="rating">
                                                                    <div class="star star-4"></div>
                                                                    <div class="review-count">
                                                                        (1<span> review</span>)
																		
                                                                    </div>
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
                                                                </div>
                                                                <div class="product-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis…</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="products-entry clearfix product-wapper">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="products-thumb">
                                                                <div class="product-lable">
                                                                    <div class="hot">Hot</div>
                                                                </div>
                                                                <div class="product-thumb-hover border">
                                                                    <a href="shop-details.html">
                                                                        <img width="600" height="600" src="media/product/6.jpg" class="post-image" alt="">
                                                                        <img width="600" height="600" src="media/product/6-2.jpg" class="hover-image back" alt="">
                                                                    </a>
                                                                </div>
                                                                <span class="product-quickview" data-title="Quick View">
                                                                    <a href="#" class="quickview quickview-button">Quick View <i class="icon-search"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <div class="products-content">
                                                                <h3 class="product-title"><a href="shop-details.html">Bora Armchair</a></h3>
                                                                <span class="price">
                                                                    <del aria-hidden="true"><span>$120.00</span></del>
                                                                    <ins><span>$100.00</span></ins>
                                                                </span>
                                                                <div class="rating">
                                                                    <div class="star star-0"></div>
                                                                    <div class="review-count">
                                                                        (0<span> review</span>)
																		
                                                                    </div>
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
                                                                </div>
                                                                <div class="product-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis…</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="products-entry clearfix product-wapper">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="products-thumb">
                                                                <div class="product-lable">
                                                                    <div class="hot">Hot</div>
                                                                </div>
                                                                <div class="product-thumb-hover">
                                                                    <a href="shop-details.html">
                                                                        <img width="600" height="600" src="media/product/3.jpg" class="post-image" alt="">
                                                                        <img width="600" height="600" src="media/product/3-2.jpg" class="hover-image back" alt="">
                                                                    </a>
                                                                </div>
                                                                <span class="product-quickview" data-title="Quick View">
                                                                    <a href="#" class="quickview quickview-button">Quick View <i class="icon-search"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <div class="products-content">
                                                                <h3 class="product-title"><a href="shop-details.html">Twin Hoops</a></h3>
                                                                <span class="price">
                                                                    <del aria-hidden="true"><span>$100.00</span></del>
                                                                    <ins><span>$90.00</span></ins>
                                                                </span>
                                                                <div class="rating">
                                                                    <div class="star star-5"></div>
                                                                    <div class="review-count">
                                                                        (3<span> review</span>)
																		
                                                                    </div>
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
                                                                </div>
                                                                <div class="product-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis…</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="products-entry clearfix product-wapper">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="products-thumb">
                                                                <div class="product-lable">
                                                                    <div class="hot">Hot</div>
                                                                </div>
                                                                <div class="product-thumb-hover border">
                                                                    <a href="shop-details.html">
                                                                        <img width="600" height="600" src="media/product/7.jpg" class="post-image" alt="">
                                                                        <img width="600" height="600" src="media/product/7-2.jpg" class="hover-image back" alt="">
                                                                    </a>
                                                                </div>
                                                                <span class="product-quickview" data-title="Quick View">
                                                                    <a href="#" class="quickview quickview-button">Quick View <i class="icon-search"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <div class="products-content">
                                                                <h3 class="product-title"><a href="shop-details.html">Diamond Bracelet</a></h3>
                                                                <span class="price">
                                                                    <del aria-hidden="true"><span>$79.00</span></del>
                                                                    <ins><span>$50.00</span></ins>
                                                                </span>
                                                                <div class="rating">
                                                                    <div class="star star-5"></div>
                                                                    <div class="review-count">
                                                                        (2<span> review</span>)
																		
                                                                    </div>
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
                                                                </div>
                                                                <div class="product-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis…</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="products-entry clearfix product-wapper">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="products-thumb">
                                                                <div class="product-lable">
                                                                    <div class="hot">Hot</div>
                                                                </div>
                                                                <div class="product-thumb-hover">
                                                                    <a href="shop-details.html">
                                                                        <img width="600" height="600" src="media/product/4.jpg" class="post-image" alt="">
                                                                        <img width="600" height="600" src="media/product/4-2.jpg" class="hover-image back" alt="">
                                                                    </a>
                                                                </div>
                                                                <span class="product-quickview" data-title="Quick View">
                                                                    <a href="#" class="quickview quickview-button">Quick View <i class="icon-search"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <div class="products-content">
                                                                <h3 class="product-title"><a href="shop-details.html">Yilver And Turquoise Earrings</a></h3>
                                                                <span class="price">$120.00</span>
                                                                <div class="rating">
                                                                    <div class="star star-4"></div>
                                                                    <div class="review-count">
                                                                        (1<span> review</span>)
																		
                                                                    </div>
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
                                                                </div>
                                                                <div class="product-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis…</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="products-entry clearfix product-wapper">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="products-thumb">
                                                                <div class="product-lable">
                                                                    <div class="hot">Hot</div>
                                                                </div>
                                                                <div class="product-thumb-hover border">
                                                                    <a href="shop-details.html">
                                                                        <img width="600" height="600" src="media/product/8.jpg" class="post-image" alt="">
                                                                        <img width="600" height="600" src="media/product/8-2.jpg" class="hover-image back" alt="">
                                                                    </a>
                                                                </div>
                                                                <span class="product-quickview" data-title="Quick View">
                                                                    <a href="#" class="quickview quickview-button">Quick View <i class="icon-search"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <div class="products-content">
                                                                <h3 class="product-title"><a href="shop-details.html">X Hoop Earrings</a></h3>
                                                                <span class="price">
                                                                    <del aria-hidden="true"><span>$200.00</span></del>
                                                                    <ins><span>$180.00</span></ins>
                                                                </span>
                                                                <div class="rating">
                                                                    <div class="star star-5"></div>
                                                                    <div class="review-count">
                                                                        (4<span> review</span>)
																		
                                                                    </div>
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
                                                                </div>
                                                                <div class="product-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis…</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="products-entry clearfix product-wapper">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="products-thumb">
                                                                <div class="product-lable">
                                                                    <div class="hot">Hot</div>
                                                                </div>
                                                                <div class="product-thumb-hover border">
                                                                    <a href="shop-details.html">
                                                                        <img width="600" height="600" src="media/product/9.jpg" class="post-image" alt="">
                                                                        <img width="600" height="600" src="media/product/9-2.jpg" class="hover-image back" alt="">
                                                                    </a>
                                                                </div>
                                                                <span class="product-quickview" data-title="Quick View">
                                                                    <a href="#" class="quickview quickview-button">Quick View <i class="icon-search"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <div class="products-content">
                                                                <h3 class="product-title"><a href="shop-details.html">Yintage Medallion Necklace</a></h3>
                                                                <span class="price">$140.00</span>
                                                                <div class="rating">
                                                                    <div class="star star-5"></div>
                                                                    <div class="review-count">
                                                                        (1<span> review</span>)
																		
                                                                    </div>
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
                                                                </div>
                                                                <div class="product-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis…</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="products-entry clearfix product-wapper">
                                                    <div class="row">
                                                        <div class="col-md-4">
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
                                                                <span class="product-quickview" data-title="Quick View">
                                                                    <a href="#" class="quickview quickview-button">Quick View <i class="icon-search"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <div class="products-content">
                                                                <h3 class="product-title"><a href="shop-details.html">Medium Flat Hoops</a></h3>
                                                                <span class="price">$150.00</span>
                                                                <div class="rating">
                                                                    <div class="star star-5"></div>
                                                                    <div class="review-count">
                                                                        (1<span> review</span>)
																		
                                                                    </div>
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
                                                                </div>
                                                                <div class="product-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis…</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="products-entry clearfix product-wapper">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="products-thumb">
                                                                <div class="product-lable">
                                                                    <div class="hot">Hot</div>
                                                                </div>
                                                                <div class="product-thumb-hover border">
                                                                    <a href="shop-details.html">
                                                                        <img width="600" height="600" src="media/product/11.jpg" class="post-image" alt="">
                                                                        <img width="600" height="600" src="media/product/11-2.jpg" class="hover-image back" alt="">
                                                                    </a>
                                                                </div>
                                                                <span class="product-quickview" data-title="Quick View">
                                                                    <a href="#" class="quickview quickview-button">Quick View <i class="icon-search"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <div class="products-content">
                                                                <h3 class="product-title"><a href="shop-details.html">Yilver And Turquoise Earrings</a></h3>
                                                                <span class="price">
                                                                    <del aria-hidden="true"><span>$150.00</span></del>
                                                                    <ins><span>$100.00</span></ins>
                                                                </span>
                                                                <div class="rating">
                                                                    <div class="star star-0"></div>
                                                                    <div class="review-count">
                                                                        (0<span> review</span>)
																		
                                                                    </div>
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
                                                                </div>
                                                                <div class="product-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis…</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="products-entry clearfix product-wapper">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="products-thumb">
                                                                <div class="product-lable">
                                                                    <div class="hot">Hot</div>
                                                                </div>
                                                                <div class="product-thumb-hover">
                                                                    <a href="shop-details.html">
                                                                        <img width="600" height="600" src="media/product/14.jpg" class="post-image" alt="">
                                                                        <img width="600" height="600" src="media/product/14-2.jpg" class="hover-image back" alt="">
                                                                    </a>
                                                                </div>
                                                                <span class="product-quickview" data-title="Quick View">
                                                                    <a href="#" class="quickview quickview-button">Quick View <i class="icon-search"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <div class="products-content">
                                                                <h3 class="product-title"><a href="shop-details.html">Bold Pearl Hoop Earrings</a></h3>
                                                                <span class="price">$150.00</span>
                                                                <div class="rating">
                                                                    <div class="star star-4"></div>
                                                                    <div class="review-count">
                                                                        (1<span> review</span>)
																		
                                                                    </div>
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
                                                                </div>
                                                                <div class="product-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis…</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <%--<nav class="pagination">
												<ul class="page-numbers">
													<li><a class="prev page-numbers" href="#">Previous</a></li>
													<li><span aria-current="page" class="page-numbers current">1</span></li>
													<li><a class="page-numbers" href="#">2</a></li>
													<li><a class="page-numbers" href="#">3</a></li>
													<li><a class="next page-numbers" href="#">Next</a></li>
												</ul>
											</nav>--%>
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


</asp:Content>
