<%@ Page Title="" Language="C#" MasterPageFile="~/majori_6.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="SHRJ.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .hero-video {
    position: relative;
    width: 100%;
    height: 100vh; /* full screen */
    overflow: hidden;
}

.hero-video video {
    position: absolute;
    top: 50%;
    left: 50%;
    min-width: 100%;
    min-height: 100%;
    transform: translate(-50%, -50%);
    object-fit: cover;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
        <CompositeScript>
            <Scripts>
                <asp:ScriptReference Name="MicrosoftAjax.js" />
                <asp:ScriptReference Name="MicrosoftAjaxWebForms.js" />
            </Scripts>
        </CompositeScript>
    </asp:ScriptManager>
    <div id="main-content" class="main-content">
        <div id="primary" class="content-area">
            <div id="content" class="site-content" role="main">

                <section class="section m-b-70">
                    <%--<div class="hero-video">
                     
    <video autoplay muted loop playsinline>
        <source src="Content/1713940466054.mp4" type="video/mp4">
        Your browser does not support the video tag.
    </video>
</div>--%>
                    <!-- Block Sliders -->
                    <div class="block block-sliders auto-height color-primary nav-center">
                        <div class="slick-sliders" data-autoplay="true" data-dots="true" data-nav="true" data-columns4="1" data-columns3="1" data-columns2="1" data-columns1="1" data-columns1440="1" data-columns="1">
                            <div class="item slick-slide">
                                <div class="item-content">
                                    <div class="content-image">
                                        <img width="1920" height="986" src="Content/media/slider/6-2.png" alt="Image Slider">
                                    </div>
                                    <div class="item-info horizontal-start vertical-
                                        ddle">
                                        <div class="content">
                                            <h2 class="title-slider">Exquisite style for
                                                <br>
                                                everyday wear.</h2>
                                            <a class="button-slider button button-primary padding-large" href="shop.aspx">Shop Now</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="item slick-slide">
                                <div class="item-content">
                                    <div class="content-image">
                                        <img width="1920" height="986" src="Content/media/slider/6-1.png" alt="Image Slider">
                                    </div>
                                    <div class="item-info horizontal-start vertical-middle">
                                        <div class="content">
                                            <h2 class="title-slider">Discover the<br>
                                                Best of the Best</h2>
                                            <a class="button-slider button button-primary padding-large" href="shop.aspx">Shop Now</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="item slick-slide">
    <div class="item-content">
        <div class="content-image">
            <img width="1920" height="986" src="Content/media/slider/6-3.png" alt="Image Slider">
        </div>
       <%-- <div class="item-info horizontal-start vertical-middle">
            <div class="content">
                <h2 class="title-slider">Discover the<br>
                    Best of the Best</h2>
                <a class="button-slider button button-primary padding-large" href="shop.aspx">Shop Now</a>
            </div>
        </div>--%>
    </div>
</div>
                        </div>
                    </div>
                </section>

                <section class="section section-padding">
                    <div class="section-container">
                        <!-- Block Product Categories (Layout 4) -->
                        <div class="block block-product-cats slider layout-4">
                            <div class="block-widget-wrap">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="text-wrap">
                                            <div class="sub-title">Find Your Favourites</div>
                                            <h2 class="title">Add to your jewellery
                                                <br>
                                                wardrobe</h2>
                                            <a href="shop.aspx" class="button button-outline border-black thick-border animation-horizontal">All Categories</a>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="product-cats-list slick-wrap">
                                            <div class="slick-sliders content-category" data-dots="0" data-slidestoscroll="true" data-nav="0" data-columns4="1" data-columns3="2" data-columns2="2" data-columns1="3" data-columns1440="3" data-columns="3">
                                                <div class="slick-item slick-slide">
                                                    <div class="item item-product-cat">
                                                        <div class="item-product-cat-content">
                                                            <a href="shop.aspx?category=bracelate">
                                                                <div class="item-image animation-horizontal">
                                                                    <img width="298" height="224" src="Content/media/product/cat-6-1.jpg" alt="Bracelets">
                                                                </div>
                                                            </a>
                                                            <div class="product-cat-content-info">
                                                                <h2 class="item-title">
                                                                    <a href="shop.aspx?category=bracelate">Bracelets</a>
                                                                </h2>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="item item-product-cat">
                                                        <div class="item-product-cat-content">
                                                            <a href="shop.aspx?category=Charms">
                                                                <div class="item-image animation-horizontal">
                                                                    <img width="298" height="224" src="Content/media/product/cat-6-2.jpg" alt="Charms">
                                                                </div>
                                                            </a>
                                                            <div class="product-cat-content-info">
                                                                <h2 class="item-title">
                                                                    <a href="shop.aspx?category=charms">Charms</a>
                                                                </h2>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="slick-item slick-slide">
                                                    <div class="item item-product-cat">
                                                        <div class="item-product-cat-content">
                                                            <a href="shop.aspx?category=earing">
                                                                <div class="item-image animation-horizontal">
                                                                    <img width="298" height="224" src="Content/media/product/cat-6-3.jpg" alt="Earrings">
                                                                </div>
                                                            </a>
                                                            <div class="product-cat-content-info">
                                                                <h2 class="item-title">
                                                                    <a href="shop.aspx?category=earings">Earrings</a>
                                                                </h2>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="item item-product-cat">
                                                        <div class="item-product-cat-content">
                                                            <a href="shope.aspx?category=necklaces">
                                                                <div class="item-image animation-horizontal">
                                                                    <img width="298" height="224" src="Content/media/product/QG106002_1.jpg" alt="Necklaces">
                                                                </div>
                                                            </a>
                                                            <div class="product-cat-content-info">
                                                                <h2 class="item-title">
                                                                    <a href="shop.aspx?category=necklaces">Necklaces</a>
                                                                </h2>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="slick-item slick-slide">
                                                    <div class="item item-product-cat">
                                                        <div class="item-product-cat-content">
                                                            <a href="shop.aspx?category=ring">
                                                                <div class="item-image animation-horizontal">
                                                                    <img width="298" height="224" src="Content/media/product/cat-6-5.jpg" alt="Rings">
                                                                </div>
                                                            </a>
                                                            <div class="product-cat-content-info">
                                                                <h2 class="item-title">
                                                                    <a href="shop.aspx?category=ring">Rings</a>
                                                                </h2>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="item item-product-cat">
                                                        <div class="item-product-cat-content">
                                                            <a href="shop.aspx?category=pendants">
                                                                <div class="item-image animation-horizontal">
                                                                    <img width="298" height="224" src="Content/media/product/501920PLEAAA00_1.jpg" alt="Rings">
                                                                </div>
                                                            </a>
                                                            <div class="product-cat-content-info">
                                                                <h2 class="item-title">
                                                                    <a href="shop.aspx?category=pendants">Pendants</a>
                                                                </h2>
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
                    </div>
                </section>

                <section class="section section-padding top-border p-t-70 m-b-70">
                    <div class="section-container">
                        <!-- Block Banners (Layout 5) -->
                        <div class="block block-banners layout-5 banners-effect">
                            <div class="block-widget-wrap">
                                <div class="block-title">
                                    <h2>Everyday Elegance</h2>
                                </div>
                                <div class="block-content">
                                    <div class="row">
                                        <div class="col-md-4 sm-m-b-40">
                                            <div class="block-widget-banner">
                                                <div class="bg-banner">
                                                    <div class="banner-wrapper banners">
                                                        <div class="banner-image">
                                                            <a href="shop.aspx">
                                                                <img width="450" height="371" src="Content/media/banner/banner-6-1.jpg" alt="Banner Image">
                                                            </a>
                                                        </div>
                                                        <div class="banner-wrapper-infor">
                                                            <div class="info">
                                                                <div class="content">
                                                                    <h3 class="title-banner">EAR STACK MAGIC</h3>
                                                                    <div class="banner-image-description">
                                                                        Fusce egestas elit eget lorem n hac habitasse platea dictumstn hac habitasse
                                                                    </div>
                                                                    <a class="button" href="shop.aspx">Shop Now</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 sm-m-b-40">
                                            <div class="block-widget-banner">
                                                <div class="bg-banner">
                                                    <div class="banner-wrapper banners">
                                                        <div class="banner-image">
                                                            <a href="shop.aspx">
                                                                <img width="450" height="371" src="Content/media/banner/banner-6-2.jpg" alt="Banner Image">
                                                            </a>
                                                        </div>
                                                        <div class="banner-wrapper-infor">
                                                            <div class="info">
                                                                <div class="content">
                                                                    <h3 class="title-banner">THE LOCKET</h3>
                                                                    <div class="banner-image-description">
                                                                        Fusce egestas elit eget lorem n hac habitasse platea dictumstn hac habitasse
                                                                    </div>
                                                                    <a class="button" href="shop.aspx">Shop Now</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="block-widget-banner">
                                                <div class="bg-banner">
                                                    <div class="banner-wrapper banners">
                                                        <div class="banner-image">
                                                            <a href="shop.aspx">
                                                                <img width="450" height="371" src="Content/media/banner/banner-6-3.jpg" alt="Banner Image">
                                                            </a>
                                                        </div>
                                                        <div class="banner-wrapper-infor">
                                                            <div class="info">
                                                                <div class="content">
                                                                    <h3 class="title-banner">AWARENESS BRACELET</h3>
                                                                    <div class="banner-image-description">
                                                                        Fusce egestas elit eget lorem n hac habitasse platea dictumstn hac habitasse
                                                                    </div>
                                                                    <a class="button" href="shop.aspx">Shop Now</a>
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
                        </div>
                    </div>
                </section>

                <section class="section section-padding top-border p-t-70 m-b-70 ">
                    <div class="section-container ">
                        <!-- Block Products (Layout 2) -->
                        <div class="block block-products layout-2 border-item slider">
                            <div class="block-widget-wrap">
                                <div class="block-title color-white">
                                    <h2>New Arrivals</h2>
                                </div>
                                <div class="block-content">
                                    <div class="content-product-list slick-wrap">
                                        <div class="slick-sliders products-list grid" data-slidestoscroll="true" data-dots="false" data-nav="1" data-columns4="1" data-columns3="2" data-columns2="3" data-columns1="3" data-columns1440="4" data-columns="4">

                                            <asp:Repeater ID="rptNewArrivals" runat="server">
                                                <ItemTemplate>
                                                    <div class="item-product slick-slide">
                                                        <div class="items">
                                                            <div class="products-entry clearfix product-wapper">

                                                                <div class="products-thumb">
                                                                    <div class="product-lable">
                                                                        <%# Convert.ToBoolean(Eval("IsTrending")) ? "<div class='hot'>Hot</div>" : "" %>
                                                                    </div>

                                                                    <div class="product-thumb-hover">
                                                                        <a href='shop_details.aspx?DesignNo=<%# Eval("DesignNo") %>'>
                                                                            <img  src='ImageHandler.ashx?id=<%# Eval("DesignID") %>&type=base'
                                                                                class="post-image" />
                                                                            <img  src='ImageHandler.ashx?id=<%# Eval("DesignID") %>&type=hover'
                                                                                class="hover-image back" />
                                                                        </a>
                                                                    </div>
                                                                    <div class="product-button">
                                                                        <div class="btn-add-to-cart">
                                                                            <a href="#" class="product-btn button">Add to cart</a>
                                                                        </div>
                                                                        <div class="btn-wishlist">
                                                                            <button class="product-btn">Wishlist</button>
                                                                        </div>
                                                                        <%--<div class="btn-compare">
         <button class="product-btn">Compare</button>
     </div>--%>
                                                                        <span class="product-quickview">
                                                                            <a href="#" class="quickview quickview-button">Quick View <i class="icon-search"></i>
                                                                            </a>
                                                                        </span>
                                                                    </div>
                                                                </div>

                                                                <div class="products-content">
                                                                    <div class="contents">
                                                                        <h3 class="product-title">
                                                                            <a href='shop-details.aspx?id=<%# Eval("DesignNo") %>'>
                                                                                <%# Eval("DesignName") %>
                                                                            </a>
                                                                        </h3>

                                                                        <span class="price">₹ <%# Eval("ProductValue_Rs", "{0:N0}") %>
                                                                        </span>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>



                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="section background-img bg-img-3 m-b-70">
                    <!-- Block Lookbook (Layout 2) -->
                    <div class="block block-lookbook layout-2">
                        <div class="lookbook-item">
                            <div class="row">
                                <div class="col-md-6 col-image">
                                    <div class="lookbook-container">
                                        <div class="lookbook-content">
                                            <div class="item">
                                                <img width="959" height="623" src="Content/media/banner/lookbook-6-1.jpg" alt="Look Book 1">
                                                <div class="item-lookbook" style="left: 52.97%; top: 22.31%">
                                                    <span class="number-lookbook">1</span>
                                                    <div class="content-lookbook" style="right: 35px; top: 10px;">
                                                        <div class="item-thumb">
                                                            <a href="shop_details.aspx">
                                                                <img width="1000" height="1000" src="Content/media/product/1.jpg" alt="">
                                                            </a>
                                                        </div>
                                                        <div class="content-lookbook-bottom">
                                                            <div class="item-title">
                                                                <a href="shop_details.aspx">Medium Flat Hoops</a>
                                                            </div>
                                                            <span class="price">
                                                                <del aria-hidden="true"><span>&#8377;150.00</span></del>
                                                                <ins><span>&#8377;100.00</span></ins>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="item-lookbook" style="left: 68.3%; top: 70.95%">
                                                    <span class="number-lookbook">1</span>
                                                    <div class="content-lookbook" style="right: 35px; bottom: 10px;">
                                                        <div class="item-thumb">
                                                            <a href="shop_details.aspx">
                                                                <img width="1000" height="1000" src="Content/media/product/2.jpg" alt="">
                                                            </a>
                                                        </div>
                                                        <div class="content-lookbook-bottom">
                                                            <div class="item-title">
                                                                <a href="shop_details.aspx">Bold Pearl Hoop Earrings</a>
                                                            </div>
                                                            <span class="price">
                                                                <del aria-hidden="true"><span>&#8377;240.00</span></del>
                                                                <ins><span>&#8377;200.00</span></ins>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-text">
                                    <div class="lookbook-intro-wrap position-center">
                                        <div class="lookbook-intro">
                                            <div class="sub-title">Discover This Week's In Australia</div>
                                            <h2 class="title">Spring Jewellery<br>
                                                Favourites</h2>
                                            <a href="shop.aspx" class="button button-outline border-black thick-border animation-horizontal">SHOP COLLECTION</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="section section-padding m-b-70">
                    <div class="section-container">
                        <!-- Block Testimonial -->
                        <div class="block block-testimonial layout-2">
                            <div class="block-widget-wrap">
                                <div class="testimonial-wrap slick-wrap">
                                    <div class="slick-sliders" data-slidestoscroll="true" data-slidestoscroll="true" data-nav="1" data-dots="0" data-columns4="1" data-columns3="1" data-columns2="1" data-columns1="2" data-columns="3">
                                        <div class="testimonial-content">
                                            <div class="item">
                                                <div class="testimonial-item">
                                                    <div class="testimonial-icon">
                                                        <div class="rating">
                                                            <div class="star star-5"></div>
                                                        </div>
                                                    </div>
                                                    <h2 class="testimonial-title">“Amazing piece of history”</h2>
                                                    <div class="testimonial-excerpt">
                                                        Blood bank canine teeth larynx occupational therapist oncologist optician plaque spinal tap stat strep... 
                                                    </div>
                                                </div>
                                                <div class="testimonial-image image-position-top">
                                                    <div class="thumbnail">
                                                        <img width="110" height="110" src="Content/media/testimonial/1.jpg" alt="">
                                                    </div>
                                                    <div class="testimonial-info">
                                                        <h2 class="testimonial-customer-name">Robet Smith</h2>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="testimonial-content">
                                            <div class="item">
                                                <div class="testimonial-item">
                                                    <div class="testimonial-icon">
                                                        <div class="rating">
                                                            <div class="star star-4"></div>
                                                        </div>
                                                    </div>
                                                    <h2 class="testimonial-title">“Fabulous Grounds”</h2>
                                                    <div class="testimonial-excerpt">
                                                        Blood bank canine teeth larynx occupational therapist oncologist optician plaque spinal tap stat strep... 
                                                    </div>
                                                </div>
                                                <div class="testimonial-image image-position-top">
                                                    <div class="thumbnail">
                                                        <img width="110" height="110" src="Content/media/testimonial/2.jpg" alt="">
                                                    </div>
                                                    <div class="testimonial-info">
                                                        <h2 class="testimonial-customer-name">Saitama One</h2>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="testimonial-content">
                                            <div class="item">
                                                <div class="testimonial-item">
                                                    <div class="testimonial-icon">
                                                        <div class="rating">
                                                            <div class="star star-5"></div>
                                                        </div>
                                                    </div>
                                                    <h2 class="testimonial-title">“Great vineyard tour and tasting!”</h2>
                                                    <div class="testimonial-excerpt">
                                                        Blood bank canine teeth larynx occupational therapist oncologist optician plaque spinal tap stat strep... 
                                                    </div>
                                                </div>
                                                <div class="testimonial-image image-position-top">
                                                    <div class="thumbnail">
                                                        <img width="110" height="110" src="Content/media/testimonial/3.jpg" alt="">
                                                    </div>
                                                    <div class="testimonial-info">
                                                        <h2 class="testimonial-customer-name">Sara Colinton</h2>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="testimonial-content">
                                            <div class="item">
                                                <div class="testimonial-item">
                                                    <div class="testimonial-icon">
                                                        <div class="rating">
                                                            <div class="star star-5"></div>
                                                        </div>
                                                    </div>
                                                    <h2 class="testimonial-title">“Stunning Design”</h2>
                                                    <div class="testimonial-excerpt">
                                                        Blood bank canine teeth larynx occupational therapist oncologist optician plaque spinal tap stat strep... 
                                                    </div>
                                                </div>
                                                <div class="testimonial-image image-position-top">
                                                    <div class="thumbnail">
                                                        <img width="110" height="110" src="Content/media/testimonial/4.jpg" alt="">
                                                    </div>
                                                    <div class="testimonial-info">
                                                        <h2 class="testimonial-customer-name">Shetty Jamie</h2>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="section section-padding top-border p-t-70 m-b-70">
                    <div class="section-container">
                        <!-- Block Products (Layout 2) -->
                        <div class="block block-products layout-2 border-item slider">
                            <div class="block-widget-wrap">
                                <div class="block-title">
                                    <h2>Trending Product</h2>
                                </div>
                                <div class="block-content">
                                    <div class="content-product-list slick-wrap">



                                        <div class="slick-sliders products-list grid"
                                            data-slidestoscroll="true"
                                            data-dots="false"
                                            data-nav="1"
                                            data-columns4="1"
                                            data-columns3="2"
                                            data-columns2="3"
                                            data-columns1="3"
                                            data-columns1440="4"
                                            data-columns="4">

                                            <asp:Repeater ID="rptTrendingProducts" runat="server">
                                                <ItemTemplate>
                                                    <div class="item-product slick-slide">
                                                        <div class="items">
                                                            <div class="products-entry clearfix product-wapper">

                                                                <!-- IMAGE -->
                                                                <div class="products-thumb">
                                                                    <div class="product-lable">
                                                                        <%# Convert.ToBoolean(Eval("IsTrending"))
                                    ? "<div class='hot'>Hot</div>"
                                    : "" %>
                                                                    </div>

                                                                    <div class="product-thumb-hover">
                                                                        <a href='shop_details.aspx?DesignNo=<%# Eval("DesignNo") %>'>
                                                                            <img src='ImageHandler.ashx?id=<%# Eval("DesignID") %>&type=base'
                                                                                class="post-image" />
                                                                            <img src='ImageHandler.ashx?id=<%# Eval("DesignID") %>&type=hover'
                                                                                class="hover-image back" />
                                                                        </a>
                                                                    </div>

                                                                    <div class="product-button">
                                                                        <%--<div class="btn-add-to-cart">
                                                                            <a href="#" class="product-btn button">Add to cart</a>
                                                                        </div>--%>
                                                                        <div class="btn-add-to-cart">
                                                                            .<a href="javascript:void(0)"
                                                                               class="product-btn add-to-cart"
                                                                               data-designid="<%# Eval("DesignID") %>"
                                                                               data-name="<%# Eval("DesignName") %>"
                                                                               data-price="<%# Eval("ProductValue_Rs") %>"
                                                                               data-qty="1">
                                                                               Add to cart
                                                                            </a>
                                                                            </div>

                                                                        <div class="btn-wishlist">
                                                                            <button class="product-btn">Wishlist</button>
                                                                        </div>
                                                                       
                                                                        <span class="product-quickview">
                                                                            <a href="#" class="quickview quickview-button">Quick View <i class="icon-search"></i>
                                                                            </a>
                                                                        </span>
                                                                    </div>
                                                                </div>

                                                                <!-- CONTENT -->
                                                                <div class="products-content">
                                                                    <div class="contents">
                                                                        <h3 class="product-title">
                                                                            <a href='shop-details.aspx?id=<%# Eval("DesignID") %>'>
                                                                                <%# Eval("DesignName") %>
                                                                            </a>
                                                                        </h3>

                                                                        <span class="price">₹ <%# Eval("ProductValue_Rs", "{0:N0}") %>
                                                                        </span>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>

                                        </div>


                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="section section-padding top-border p-t-60 m-b-80">
                    <div class="section-container">
                        <!-- Block Newsletter (Layout 2) -->
                        <div class="block block-newsletter layout-2 one-col">
                            <div class="block-widget-wrap">
                                <div class="newsletter-title-wrap">
                                    <h2 class="newsletter-title">Latest From ShreeHari!</h2>
                                    <div class="newsletter-text">Sign-up to receive 10% off your next purchase. Plus hear about new arrivals and offers.</div>
                                </div>
                                <div action="#" method="post" class="newsletter-form">
                                    <input type="email" name="your-email" value="" size="40" placeholder="Email address">
                                    <span class="btn-submit">
                                        <input type="submit" value="SUBSCRIBE">
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="section m-b-0">
                    <!-- Block Instagram -->
                    <div class="block block-instagram slider no-space">
                        <div class="slick-wrap">
                            <div class="slick-sliders fullwidth" data-dots="false" data-item_row="1" data-nav="false" data-columns4="1" data-columns3="2" data-columns2="3" data-columns1="4" data-columns="5">
                                <div class="item slick-slide">
                                    <a class="instagram" href="#">
                                        <img width="450" height="450" src="Content/media/banner/instagram-1.jpg" alt="Image Slider">
                                    </a>
                                </div>
                                <div class="item slick-slide">
                                    <a class="instagram" href="#">
                                        <img width="450" height="450" src="Content/media/banner/instagram-2.jpg" alt="Image Slider">
                                    </a>
                                </div>
                                <div class="item slick-slide">
                                    <a class="instagram" href="#">
                                        <img width="450" height="450" src="Content/media/banner/instagram-3.jpg" alt="Image Slider">
                                    </a>
                                </div>
                                <div class="item slick-slide">
                                    <a class="instagram" href="#">
                                        <img width="450" height="450" src="Content/media/banner/instagram-4.jpg" alt="Image Slider">
                                    </a>
                                </div>
                                <div class="item slick-slide">
                                    <a class="instagram" href="#">
                                        <img width="450" height="450" src="Content/media/banner/instagram-5.jpg" alt="Image Slider">
                                    </a>
                                </div>
                                <div class="item slick-slide">
                                    <a class="instagram" href="#">
                                        <img width="450" height="450" src="Content/media/banner/instagram-6.jpg" alt="Image Slider">
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

            </div>
            <!-- #content -->
        </div>
        <!-- #primary -->
    </div>

   <script>
       document.addEventListener("click", function (e) {
           var btn = e.target.closest(".add-to-cart");
           if (!btn) return;

           fetch("/index.aspx/AddItem", {
               method: "POST",
               headers: { "Content-Type": "application/json; charset=utf-8" },
               body: JSON.stringify({
                   DesignID: btn.getAttribute("data-designid"),
                   DesignName: btn.getAttribute("data-name"),
                   Price: parseFloat(btn.getAttribute("data-price")),
                   Quantity: parseInt(btn.getAttribute("data-qty"))
               })
           })
               .then(res => res.json())
               .then(res => {
                   if (res.d === "LOGIN") {
                       window.location.href = "login.aspx";
                   } else if (res.d === "OK") {
                       alert("Added to cart");
                   } else {
                       alert(res.d);
                   }
               })
               .catch(err => console.error(err));
       });
   </script>

</asp:Content>
