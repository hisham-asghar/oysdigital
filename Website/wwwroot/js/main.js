
/*================================================
[  Table of contents  ]
================================================
  1. Mean Menu Active
  2. Sticky Menu Active
  3. Category Menu Active
  4. Nivo slider Active
  5. Owl Carousel Active
    5.1 All Product Slider Active
    5.2 Related Product slider Active
    5.3 All-List-Product Slider Active
    5.4 Brand Active
    5.5 Our Blog Active Home 2
    5.6 Hot Deal Product  Home 3
    5.7 Bestseller Product3 Active Home 3
    5.8 New Arrival List Product Active Home 3
    5.9 Electronic Product3 Active Home 3
    5.10 Latest Blog Active Home 3
    5.11 Blog Post Slider Active
    5.12 Product Tab Menu Active
  6. Slick Slider Active
    6.1 hot deal Slider Active
    6.2 Slide Active2 Left Side Slider Active
    6.3 Slide Active3 Slider Active
    6.4 Slide Active Home 2
    6.5 Modal Slider Active
  7. Count Down Active
  8. Tooltip Active
  9. ScrollUp Active
  10. Counter Up
  11. FAQ Accordion Active
  12.  Wow Active
  13. Isotope Active
  14. Fancybox Active
  15. All Toggle Active
    15.1 Showlogin Toggle Function
    15.2 Showcoupon Toggle Function
    15.3 Create An Account Toggle Function
    15.4 Create An Account Toggle Function
    15.5 Pyment Toggle Function
  16. Chosen Active
  17. Instafeed active
  18. Price Slider Active
  19. EasyZoom Active
================================================*/

(function ($) {
	"use Strict";
/*---------------------------------
    1. Mean Menu Active
-----------------------------------*/
// jQuery('.mobile-menu-area nav').meanmenu({
//     meanMenuContainer: '.mobile-menu',
//     meanScreenWidth: "991"
// });
/*---------------------------------
    2. Sticky Menu Active
-----------------------------------*/
$(window).scroll(function() {
if ($(this).scrollTop() >150){
    $('.header-sticky').addClass("sticky");
  }
  else{
    $('.header-sticky').removeClass("sticky");
  }
});
/*--------------------------
	3. Category Menu Active
---------------------------- */
 $('.rx-parent').on('click', function(){
    $('.rx-child').slideToggle();
    $(this).toggleClass('rx-change');
});
$(".embed-responsive iframe").addClass("embed-responsive-item");
$(".carousel-inner .item:first-child").addClass("active");
//    category heading
$('.category-heading').on('click', function(){
    $('.category-menu-list').slideToggle(300);
});

/*----------------------------------
    4. Nivo slider Active
-----------------------------------*/
 // $('#slider').nivoSlider({
 //     manualAdvance:true,
 //     directionNav: false,
 //     controlNav: true,
 //     effect: 'fade',
 //     slices: 18,
 //     pauseTime: 5000,
 //     controlNav: true,
 //     pauseOnHover: false,
 //     prevText: '<i class="ion-chevron-left"></i>',
 //     nextText: '<i class="ion-chevron-right"></i>',
 // });
 $("#slider, #mobile_slider").owlCarousel({
    loop:true,
    items: 1,
    margin:10,
    nav:true,
		autoplay: 5000,
		navText : ["<i class='fa fa-chevron-left'></i>","<i class='fa fa-chevron-right'></i>"]
	});

/*==================================
   5. Owl Carousel Active
====================================*/


/*-----------------------------------
  5.1 All Product Slider Active
----------------------------------*/
 $('.all-product')
        .on('changed.owl.carousel initialized.owl.carousel', function (event) {
            $(event.target)
                .find('.owl-item').removeClass('last')
                .eq(event.item.index + event.page.size - 1).addClass('last');
        }).owlCarousel({
        smartSpeed: 1000,
        nav: true,
        navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
        responsive: {
            0: {
                items: 1
            },
            450: {
                items: 1
            },
            600: {
                items: 2
            },
            992: {
                items: 3
            },
            1200: {
                items: 4
            }
        }
    })
/*-----------------------------------
  5.2 Related Product slider Active
----------------------------------*/
 $('.related-products')
        .on('changed.owl.carousel initialized.owl.carousel', function (event) {
            $(event.target)
                .find('.owl-item').removeClass('last')
                .eq(event.item.index + event.page.size - 1).addClass('last');
        }).owlCarousel({
        smartSpeed: 1000,
        nav: true,
        navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
        responsive: {
            0: {
                items: 1
            },
            450: {
                items: 1
            },
            600: {
                items: 3
            },
            992: {
                items: 4
            },
            1200: {
                items: 5
            }
        }
    })
/*-----------------------------------
  5.3 All-List-Product Slider Active
----------------------------------*/
 $('.all-list-product')
     .on('changed.owl.carousel initialized.owl.carousel', function (event) {
            $(event.target)
                .find('.owl-item').removeClass('last')
                .eq(event.item.index + event.page.size - 1).addClass('last');
        }).owlCarousel({
        smartSpeed: 1000,
        nav: true,
        navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
        responsive: {
            0: {
                items: 1
            },
            450: {
                items: 1
            },
            600: {
                items: 2
            },
            1000: {
                items: 2
            }
        }
    })
/*-----------------------------------
  5.4 Brand Active
----------------------------------*/
 // $('.brand-active').owlCarousel({
 //        smartSpeed: 1000,
 //        nav: false,
 //        navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
 //        autoplay: true,
 //        loop: true,
 //        responsive: {
 //            0: {
 //                items: 2
 //            },
 //            450: {
 //                items: 2
 //            },
 //            600: {
 //                items: 3
 //            },
 //            1000: {
 //                items: 5
 //            }
 //        }
 //    })
/*-----------------------------------
  5.5 Our Blog Active Home 2
----------------------------------*/
 // $('.our-blog-active').owlCarousel({
 //        smartSpeed: 1000,
 //        nav: true,
 //        navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
 //        responsive: {
 //            0: {
 //                items: 1
 //            },
 //            450: {
 //                items: 1
 //            },
 //            600: {
 //                items: 1
 //            },
 //            1000: {
 //                items: 1
 //            }
 //        }
 //    })
 /*-----------------------------------
  5.6 Hot Deal Product  Home 3
----------------------------------*/
 $('.hot-deal-of-product')
     .on('changed.owl.carousel initialized.owl.carousel', function (event) {
            $(event.target)
                .find('.owl-item').removeClass('last')
                .eq(event.item.index + event.page.size - 1).addClass('last');
        }).owlCarousel({
        smartSpeed: 1000,
        nav: true,
        navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
        responsive: {
            0: {
                items: 1
            },
            450: {
                items: 1
            },
            600: {
                items: 2
            },
            1000: {
                items: 2
            }
        }
    })
/*--------------------------------------
  5.7 Bestseller Product3 Active Home 3
---------------------------------------*/
 $('.bestseller-product3')
        .on('changed.owl.carousel initialized.owl.carousel', function (event) {
            $(event.target)
                .find('.owl-item').removeClass('last')
                .eq(event.item.index + event.page.size - 1).addClass('last');
        }).owlCarousel({
        smartSpeed: 1000,
        nav: true,
        navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
        responsive: {
            0: {
                items: 1
            },
            450: {
                items: 1
            },
            600: {
                items: 2
            },
            992: {
                items: 4
            },
            1200: {
                items: 5
            }
        }
    })
/*----------------------------------------------
  5.8 New Arrival List Product Active Home 3
------------------------------------------------*/
 $('.new-arrival-list-product')
     .on('changed.owl.carousel initialized.owl.carousel', function (event) {
            $(event.target)
                .find('.owl-item').removeClass('last')
                .eq(event.item.index + event.page.size - 1).addClass('last');
        }).owlCarousel({
        smartSpeed: 1000,
        nav: true,
        navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
        responsive: {
            0: {
                items: 1
            },
            450: {
                items: 1
            },
            600: {
                items: 2
            },
            992: {
                items: 2
            },
            1200: {
                items: 3
            }
        }
    })
/*---------------------------------------
  5.9 Electronic Product3 Active Home 3
-----------------------------------------*/
 $('.electronic-product3')
        .on('changed.owl.carousel initialized.owl.carousel', function (event) {
            $(event.target)
                .find('.owl-item').removeClass('last')
                .eq(event.item.index + event.page.size - 1).addClass('last');
        }).owlCarousel({
        smartSpeed: 1000,
        nav: true,
        navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
        responsive: {
            0: {
                items: 1
            },
            450: {
                items: 1
            },
            600: {
                items: 2
            },
            992: {
                items: 4
            },
            1200: {
                items: 5
            }
        }
    })
 /*-----------------------------------
  5.10 Latest Blog Active Home 3
----------------------------------*/
 // $('.latest-blog-active').owlCarousel({
 //        smartSpeed: 1000,
 //        nav: true,
 //        navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
 //        responsive: {
 //            0: {
 //                items: 1
 //            },
 //            450: {
 //                items: 1
 //            },
 //            600: {
 //                items: 1
 //            },
 //            1000: {
 //                items: 2
 //            }
 //        }
 //    })
/*------------------------------
    5.11 Blog Post Slider Active
-------------------------------- */
 // $('.post-slider').owlCarousel({
 //        autoplay: true,
 //        autoplayTimeout: 5000,
 //        loop: true,
 //        nav: true,
 //        navText: ['<i class="ion-arrow-left-b"></i>', '<i class="ion-arrow-right-b"></i>'],
 //        responsive: {
 //            0: {
 //                items: 1
 //            },
 //            450: {
 //                items: 1
 //            },
 //            600: {
 //                items: 1
 //            },
 //            1000: {
 //                items: 1
 //            }
 //        }
 //    })
/*-----------------------------------
    5.12 Product Tab Menu Active
----------------------------------*/
 $('.single-product-tab-menu').owlCarousel({
        smartSpeed: 1000,
        margin: 20,
        loop: true,
        nav: true,
        navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
        responsive: {
            0: {
                items: 2
            },
            450: {
                items: 4
            },
            600: {
                items: 4
            },
            1000: {
                items: 4
            }
        }
    })
/*==================================
   6. Slick Slider Active
====================================*/


/*-----------------------------------
  6.1 hot deal Slider Active
-------------------------------------*/
$('.slide-active').slick({
        vertical: true,
		prevArrow: '<i class="fa fa-angle-left"></i>',
		nextArrow: '<i class="fa fa-angle-right slick-next-btn"></i>',
        slidesToShow: 2,
        responsive: [
            {
              breakpoint: 1200,
              settings: {
                slidesToShow: 2,
                slidesToScroll: 2
              }
            },
            {
              breakpoint: 768,
              settings: {
                slidesToShow: 3,
                slidesToScroll: 3
              }
            },
            {
              breakpoint: 480,
              settings: {
                slidesToShow: 1,
                slidesToScroll: 1
              }
            }
          ]
	});
/*-----------------------------------------
  6.2 Slide Active2 Left Side Slider Active
-------------------------------------------*/
$('.slide-active2').slick({
		rows: 5,
        vertical: false,
		prevArrow: '<i class="fa fa-angle-left"></i>',
		nextArrow: '<i class="fa fa-angle-right slick-next-btn"></i>',
        responsive: [
            {
              breakpoint: 1200,
              settings: {
                rows: 5,
              }
            },
            {
              breakpoint: 991,
              settings: {
                rows: 3,
              }
            },
            {
              breakpoint: 480,
              settings: {
                rows: 2,
              }
            }
          ]
	});
/*-----------------------------------
  6.3 Slide Active3 Slider Active
----------------------------------*/
// $('.slide-active3').slick({
// 		slidesToShow: 3,
//         vertical: true,
// 		prevArrow: '<i class="fa fa-angle-left"></i>',
// 		nextArrow: '<i class="fa fa-angle-right slick-next-btn"></i>',
//         responsive: [
//             {
//               breakpoint: 1024,
//               settings: {
//                 slidesToShow: 3,
//                 slidesToScroll: 3
//               }
//             },
//             {
//               breakpoint: 600,
//               settings: {
//                 slidesToShow: 2,
//                 slidesToScroll: 2
//               }
//             },
//             {
//               breakpoint: 480,
//               settings: {
//                 slidesToShow: 1,
//                 slidesToScroll: 1
//               }
//             }
//           ]
// 	});
/*-----------------------------------
  6.4 Slide Active Home 2
----------------------------------*/
$('.slide-active-home-2').slick({
		slidesToShow: 1,
		prevArrow: '<i class="fa fa-angle-left"></i>',
		nextArrow: '<i class="fa fa-angle-right slick-next-btn"></i>',
	});
/*-----------------------------------
  6.5 Modal Slider Active
----------------------------------*/
// $('.modal-tab-menu-active').slick({
// 		slidesToShow: 4,
// 		arrows: false,
//         dots: true
// 	});
$('.modal').on('shown.bs.modal', function (e) {
    $('.modal-tab-menu-active').resize();
})
/*-----------------------------------
  7. Count Down Active
----------------------------------*/
// $('[data-countdown]').each(function() {
// 	var $this = $(this), finalDate = $(this).data('countdown');
// 	$this.countdown(finalDate, function(event) {
// 		$this.html(event.strftime('<div class="single-count"><span>%D</span>Days</div><div class="single-count"><span>%H</span>Hours</div><div class="single-count"><span>%M</span>Mins</div><div class="single-count"><span>%S</span>Secs</div>'));
// 	});
// });
/*---------------------------------
   8. Tooltip Active
-----------------------------------*/
$('.product-action a,.product-price a,.socil-icon li a,.blog-social-icon li a').tooltip({
        animated: 'fade',
        placement: 'top',
        container: 'body'
});

/*----------------------------------
   9. ScrollUp Active
-----------------------------------*/
// $.scrollUp({
//     scrollText: '<i class="ion-chevron-up"></i>',
//     easingType: 'linear',
//     scrollSpeed: 900,
//     animation: 'fade'
// });
/*--------------------------
    10. Counter Up
---------------------------- */
    // $('.counter').counterUp({
    //     delay: 70,
    //     time: 5000
    // });
/* ---------------------------
	11. FAQ Accordion Active
* ---------------------------*/
  $('.panel-heading a').on('click', function() {
    $('.panel-default').removeClass('active');
    $(this).parents('.panel-default').addClass('active');
  });
/*--------------------------
   12.  Wow Active
---------------------------- */
new WOW().init();
/*--------------------------
   13. Isotope Active
---------------------------- */
// $('.protfolio-active').imagesLoaded( function() {
// // images have loaded
//     // init Isotope
//     var $grid = $('.protfolio-active').isotope({
//       // options
//     });
//     // filter items on button click
//     $('.protfolio-menu-active').on( 'click', 'li', function() {
//       var filterValue = $(this).attr('data-filter');
//       $grid.isotope({ filter: filterValue });
//
//           $(this).siblings('.active').removeClass('active');
//           $(this).addClass('active');
//           event.preventDefault();
//     });
// });

/*--------------------------
    14. Fancybox Active
---------------------------- */
$(".fancybox").fancybox({
     padding: 0,
});
/*==================================
   15. All Toggle Active
====================================*/
/*---------------------------------
	15.1 Showlogin Toggle Function
-----------------------------------*/
// $( '#showlogin' ).on('click', function() {
//     $( '#checkout-login' ).slideToggle(900);
// });
/*----------------------------------
	15.2 Showcoupon Toggle Function
------------------------------------*/
// $( '#showcoupon' ).on('click', function() {
//     $( '#checkout_coupon' ).slideToggle(600);
// });
/*------------------------------------------
	15.3 Create An Account Toggle Function
--------------------------------------------*/
 // $( '#cbox' ).on('click', function() {
 //    $( '#cbox_info' ).slideToggle(900);
 // });
/*------------------------------------------
	15.4 Create An Account Toggle Function
---------------------------------------------*/
 // $( '#ship-box' ).on('click', function() {
 //    $( '#ship-box-info' ).slideToggle(1000);
 // });
/*------------------------------------------
	15.5 Pyment Toggle Function
---------------------------------------------*/
// $(".payment_method_cheque-li").on('click', function(){
//   $(".payment_method_cheque").show(500);
//   $(".payment_method_paypal").hide(500);
// });
// $(".payment_method_paypal-li").on('click', function(){
//   $(".payment_method_paypal").show(500);
//   $(".payment_method_cheque").hide(500);
// });
/*----------------------------------
	16. Chosen Active
------------------------------------*/
$(".chosen-select").chosen({disable_search_threshold: 10});
/*----------------------------------
	17. Instafeed active
------------------------------------*/
// if($('#Instafeed').length) {
//     var feed = new Instafeed({
//         get: 'user',
//         userId: 7093388560,
//         accessToken: '7093388560.1677ed0.8e1a27120d5a4e979b1ff122d649a273',
//         target: 'Instafeed',
//         resolution: 'thumbnail',
//         limit: 6,
//         template: '<li><a href="{{link}}" target="_new"><img src="{{image}}" /></a></li>',
//     });
//     feed.run();
// }
/*----------------------------------
    18. Price Slider Active
------------------------------------*/
// $( "#slider-range" ).slider({
//       range: true,
//       min:  33,
//       max: 145,
//       values: [ 33, 145 ],
//       slide: function( event, ui ) {
//         $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
//       }
//     });
//     $( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
//       " - $" + $( "#slider-range" ).slider( "values", 1 ) );
/*----------------------------------
    19. EasyZoom Active
------------------------------------*/
var $easyzoom = $('.easyzoom').easyZoom();


$(".login").click(function(){
	$("#loginModal").modal('show');
});

$("#add_new_address").click(function(){
	$("#new_address_modal").modal('show');
});

$("body").on('click', '.open-modal', function(){
	var modal = $(this).data('modal-name');
	$(modal).modal('show');
});

$('#map_container').on('shown.bs.modal', function (e) {

	// GET CURRENT ADDRESS
	navigator.geolocation.getCurrentPosition(function(location) {

		if(!location.coords.latitude) {
			return $('#map_container').modal('hide');
		}

		$('#us2-address').hide();

		setTimeout(function(){
			$('#us2').locationpicker({
					location: {
							latitude: location.coords.latitude,
							longitude: location.coords.longitude
					},
					radius: 0,
					zoom: 18,
					inputBinding: {
							latitudeInput: $('#latitude'),
							longitudeInput: $('#longitude'),
							locationNameInput: $('#us2-address')
					},
					autocompleteOptions: {
							types: ['(street)'],
							componentRestrictions: {country: 'uae'}
					},
					addressFormat : 'street',
					enableReverseGeocode : true,
					markerInCenter: true,
					enableAutocompleteBlur: true,
					enableAutocomplete: false,
					onChanged: function(currentLocation, radius, isMarkerDropped) {
						var addressComponents = $(this).locationpicker('map').location.addressComponents;
						var address = (addressComponents.addressLine1 || "") + " " +(addressComponents.addressLine2 || "")
						$('#us2-address').val(address);
					},
					oninitialized: function(component) {
        		var addressComponents = $(component).locationpicker('map').location.addressComponents;
						var address = (addressComponents.addressLine1 || "") + " " +(addressComponents.addressLine2 || "")
						$('#us2-address').val(address);
    		}
			});
		},100);


	}, function(){
		return $('#map_container').modal('hide');
	});
});

/* SIDE MENU */
var pushbar =   new Pushbar({
	blur:false,
	overlay:true,
});
$("#open_side_menu").click(function(){
	pushbar.open('side_menu');
})

$("#toggleSearch").click(function(){
	$("#search_bar_mobile").toggleClass('hide');
})

/* NAVBAR */
$(function(){
    $("#open_location_picker").popover({
        html : true,
				container: '.header-top-menu',
        content: function() {
          var content = $(this).attr("data-popover-content");
          return $(content).children(".popover-body").html();
        },
        title: function() {
          var title = $(this).attr("data-popover-content");
          return $(title).children(".popover-heading").html();
        }
    });


		var pincode = localStorage.getItem('area');

		$("#open_location_picker").click(function(){
			// $("body, html").toggleClass('hide_scroll');
			// $("#location-picker-bg").toggleClass('hidden');
			var u = localStorage.getItem('user_session_id');

		  if(u) {
				$("#address_picker_modal").modal({
					backdrop: 'static',
					keyboard: false
				});
			}
			else {
				$("#location_picker_modal").modal({
					backdrop: 'static',
					keyboard: false
				});
			}
		});

		if(pincode) {
			$("#open_location_picker").html(pincode)
		}

		// if(!pincode) {
		// 	$("#open_location_picker").click();
		// }

		// $("body").on('click','.use_current_location',function(){
		// 	navigator.geolocation.getCurrentPosition(function(position) {
		// 	        var latitude = position.coords.latitude;
		// 	        var longitude = position.coords.longitude;
		// 					// GET PINCODE
		// 					var latlng = new google.maps.LatLng(latitude, longitude);
		// 					geocoder = new google.maps.Geocoder();
    //
		// 					    geocoder.geocode({'latLng': latlng}, function(results, status) {
		// 					        if (status == google.maps.GeocoderStatus.OK) {
		// 					            if (results[0]) {
		// 					                for (j = 0; j < results[0].address_components.length; j++) {
		// 					                    if (results[0].address_components[j].types[0] == 'postal_code') {
		// 																$(".current_pincode").val( results[0].address_components[j].short_name );
		// 																$(".popover .submit_location").click();
		// 															}
		// 					                }
		// 					            }
		// 					        } else {
		// 					            alert("Geocoder failed due to: " + status);
		// 					        }
		// 					    });
		// 	});
		// });

		// SUBMIT LOCATION
		$("body").on('click', ".submit_location", function(){
			$(".popover #non_serviceable").addClass('hide');
			var pincode = $(".header-top-menu .current_pincode").last().val();
			if(!pincode) {
				return alert("Please enter your Pincode");
			}
			// VALIDATE IF PINCODE IS SERVICEABLE
			// showLoadingSpinner("Updating Location..");
			$.get('/ajax/store/check_service_pincode?response_type=JSON&pincode='+pincode, function(data){
				var is_serviceable = data.is_serviceable;
				if(is_serviceable) {
					localStorage.setItem('pincode', pincode);
					$("#open_location_picker").html(pincode);
					setTimeout(function(){
						$("#open_location_picker").click();
					},500);
				}
				else {
					$(".popover #non_serviceable").removeClass('hide');
				}
				// showAddedToCart("Location Updated");
			});
		});
});


})(jQuery);

$(".sign_in_social").click(function(){
	$("#loginModal").modal('hide');
	showLoadingSpinner("Logging you in..")
})

var overlay, is_loading = false;

function showLoadingSpinner(text) {
	if(overlay && overlay.hide) {
		overlay.hide()
	}
	var opts = {
		lines: 13, // The number of lines to draw
		length: 11, // The length of each line
		width: 3, // The line thickness
		radius: 17, // The radius of the inner circle
		corners: 1, // Corner roundness (0..1)
		rotate: 0, // The rotation offset
		color: '#FFF', // #rgb or #rrggbb
		speed: 1, // Rounds per second
		trail: 60, // Afterglow percentage
		shadow: false, // Whether to render a shadow
		hwaccel: false, // Whether to use hardware acceleration
		className: 'spinner', // The CSS class to assign to the spinner
		zIndex: 2e9, // The z-index (defaults to 2000000000)
		top: 'auto', // Top position relative to parent in px
		left: 'auto' // Left position relative to parent in px
	};
	var target = document.createElement("div");
	document.body.appendChild(target);
	var spinner = new Spinner(opts).spin(target);
	overlay = iosOverlay({
		text: text || "Updating Cart",
		spinner: spinner
	});
	is_loading = true;
}

function showAddedToCart(text) {
	if(!is_loading) {
		overlay = iosOverlay({
			icon: "/assets/js/vendor/js-spinner/img/check.png",
			text: text
		});
	}
	else {
		overlay.update({
			icon: "/assets/js/vendor/js-spinner/img/check.png",
			text: text
		});
	}
	setTimeout(function(){
		overlay.hide()
	},2000)
}

$(".lazy_load").lazyload();
