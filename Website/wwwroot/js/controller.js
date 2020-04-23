var app = angular.module('HitchesGlitchesWeb', ['ngMap']);

app.config(function($interpolateProvider) {
  $interpolateProvider.startSymbol('{[{');
  $interpolateProvider.endSymbol('}]}');
});

app.controller('LoginController', function($scope, $http, $timeout){

  $scope.form = {};
  $scope.form.email = "";

  $scope.show_otp = false;
  $scope.show_passDeliveryControllerword = false;
  $scope.show_login_btn = false;

  function validateEmail(email) {
      var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return re.test(String(email).toLowerCase());
  }

  $scope.sendOTP = function() {
    showLoadingSpinner("Sending OTP..");
    $http({
      url : "/auth/local/generate_otp",
      data : { phone_no : $scope.form.email  },
      method: "POST"
    })
    .then(function(){
      showAddedToCart("OTP Sent");
      $scope.show_password = false;
      $scope.show_otp = true;
      $scope.form.password = "";
      $scope.show_login_btn = true;
      $scope.form.otp = "";
      $timeout(function(){
        $scope.show_resend_otp = true;
      }, 5000);
    }, function() {
      return window.location.href="/account/signup";
    })
  }

  $scope.initLogin = function() {
    if(!$scope.form.email) {
      return alert("Invalid Email / Phone Number");
    }
    else {
      // CHECK IF CONTENT IS EMAIL OR PHONE NUMBER
      var is_nan = isNaN($scope.form.email);

      if(is_nan) {
        // CHECK FOR EMAIL VALIDATION
        if(validateEmail($scope.form.email)) {
          $scope.show_password = true;
          $scope.show_otp = false;
          $scope.form.otp = "";
          $scope.show_login_btn = true;
        }
        else {
          return alert("Invalid Email / Phone Number");
        }
      }
      else {
        // SEND OTP
        $scope.sendOTP();
      }

    }
  }

})

app.controller('HomeController', function($scope, $http, $timeout){

  /* GET AREA */
  $scope.loadLocations = function() {
    $http({
      url : "/ajax/store/locations",
      params : { response_type: "JSON" },
      data : { },
      method: "GET"
    })
    .then(function(res){
      var locations = res.data['locations'];
      $scope.all_locations = _.filter(locations, function(l){
        return l.name != "Others" && l.name != "others";
      });

      // IF AREA IS NOT FOUND, SHOW PICKER
      var area = localStorage.getItem('area');
      var emirate = localStorage.getItem('emirate');

      if(!area) {
        $("#location_picker_modal").modal({
          backdrop: 'static',
          keyboard: false
        });
      }
      else if(area && emirate) {
        $scope.emirate = emirate;
        $scope.area = area;
        $scope.loadAreas();
      }

    });

  }

  $scope.loadAreas = function() {
    if($scope.emirate) {
      var areas = _.filter($scope.all_locations, function(l){
        return l.name == $scope.emirate;
      });

      if(areas[0] && areas[0].serving_locations) {
        $scope.areas = areas[0].serving_locations;
      }

    }
  }

  $scope.updateArea = function() {
    if($scope.emirate && $scope.area) {
      localStorage.setItem('emirate', $scope.emirate);
      localStorage.setItem('area', $scope.area);
      $("#location_picker_modal").modal('hide');
      $("#open_location_picker").html($scope.area);
    }
  }

  $scope.addressChanged = function(a) {

    if(!a) {
      return false;
    }

    $scope.current_address_id = a._id;
    $scope.current_address = a;

    if(!a.locality || !a.city) {
      var c = confirm("Address doesn't contain area. Do you want to update?");
      if(c) {
        window.location.href="/account/address";
      }
    }

  }

  $scope.updateAddress = function(){

    if($scope.current_address && $scope.current_address.locality) {
      localStorage.setItem('emirate', $scope.current_address.city);
      localStorage.setItem('area', $scope.current_address.locality);
      $("#open_location_picker").html($scope.current_address.locality);
      $("#address_picker_modal").modal('hide');
    }

  }

  $scope.loadAddress = function() {
    $http({
      url : "/ajax/account/address",
      params : { response_type: "JSON" },
      method: "GET"
    })
    .then(function(res){
      $scope.all_address = res.data;
      // IF AREA IS NOT FOUND, SHOW PICKER
      var area = localStorage.getItem('area');
      var emirate = localStorage.getItem('emirate');

      if(!area) {
        $("#address_picker_modal").modal({
          backdrop: 'static',
          keyboard: false
        });
      }

    });
  }
  // CHECK IF USER IS LOGGED IN, IF NOT LOAD THE LOCATIONS
  var u = localStorage.getItem('user_session_id');

  if(u) {
    var user = JSON.parse(localStorage.getItem('user'));
    // LOAD ADDRESS OF THE CUSTOMER
    $scope.loadAddress();
  }
  else {
    $scope.loadLocations();
  }

  /* END GET AREA */

  $scope.showPaymentWindow = function() {
    // SHOW BLOCKER TO PAY
    var amount = $scope.payment_requests[0]['amount'];

    var msg = "";

    if($scope.payment_requests[0]['order_id']) {
      msg = "for your order"
    }

    if($scope.payment_requests[0]['customer_subscription_id']) {
      msg = "for your package"
    }


    if(amount > 0) {
      swal({
        title : 'Pending Payment of AED ' +  amount,
        text : 'You have a pending payment of AED '+ amount + " " + msg,
        icon : 'warning',
        button: "Pay Now"
      })
      .then(function(c){
        // Redirect to Payment Request
        if(c) {
          window.location.href = "/payment_requests/pay/" + $scope.payment_requests[0]['_id'];
        }
      })
    }
  }

  // CHECK IF ANY PAYMENT REQUESTS ARE OUTSTANDING
  $scope.getPaymentRequests = function() {

    $http({
      url : "/ajax/payment_requests",
      params : {
        "response_type": "JSON",
        "filter.status" : "AWAIT_PAYMENT"
      },
      method: "GET"
    })
    .then(function(res){
      $scope.payment_requests = res.data;

      if($scope.payment_requests && $scope.payment_requests.length > 0) {
        $scope.showPaymentWindow();
      }

    });
  }

  $scope.getPaymentRequests();
})

app.controller('CollectionController', function($scope, $http, $timeout){

  $scope.loadBestSellers = function() {
    $http({
      url : "/ajax/collections/trending-products",
      params : { response_type: "JSON" },
      method: "GET"
    })
    .then(function(res){
      $scope.best_sellers = res.data.product_ids;
      // INIT JQUERY PLUGIN
      $timeout(function() {
        $('.best-seller-products')
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
                   items: 4
               }
           }
       })
      },100);
    })
  }


  $scope.loadTrendingProducts = function() {
    $http({
      url : "/ajax/collections/trending-products",
      params : { response_type: "JSON" },
      method: "GET"
    })
    .then(function(res){
      $scope.trending_products = res.data.product_ids;
      // INIT JQUERY PLUGIN
      $timeout(function() {
        $('.trending-products')
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
                   items: 4
               }
           }
       })
      },100);
    })
  }

});

app.controller('CategoryController', function($scope, $http){
  $scope.categories = [];

  $scope.loadCategories = function(){
    // FETCH CATEGORIES
    $http({
      url : "/ajax/category",
      params : { response_type: "JSON" },
      method: "GET"
    })
    .then(function(res){
      $scope.categories = res.data.categories;
      window.localStorage.setItem('categories', JSON.stringify($scope.categories))
      setTimeout(function(){
        $("#category_container").removeClass('hide');
      },100)
    })
  }

  $scope.openChildCategory = function(id, url, name, child_category) {
    var child_category = window.child_categories ? window.child_categories[id] : child_category;
    $scope.current_category = name;
    // IF THERE ARE NO CHILD CATEGORY
    if(!child_category) {
      return window.location.href = "/" + url;
    }

    // OPEN CATEGORY PICKER
    $scope.child_categories = _.map(child_category, function(c){
      return c['category_id']
    });

    $("#child_category_modal").modal('show');

  }

});

app.controller('CartController', function($scope, $http, $rootScope, $timeout){
  $scope.cart = {};
  $scope.cart.products = [];
  $scope.cart.delivery_charges = 0;

  $scope.best_sellers = [];

  $scope.hideDeliveryDetails = function(p) {
    $scope.show_qty = false;
    _.each(p.product_meta_datas, function(m){
      if(m.product_meta_name == "show_qty" && m.product_meta_value == "true") {
        $scope.show_qty = true;
      }
    });
    return $scope.show_qty;
  }

  $scope.capitalize = function(d) {
    if(!d) {
      return "";
    }
    d = d.toLowerCase();
    return d.charAt(0).toUpperCase() + d.slice(1);
  }

  $scope.formatDate = function(d) {
    if(d) {
      return moment(d).format('DD/MM/YYYY');
    }
  }

  $scope.deleteCoupon = function() {
    // CHECK VALIDATITY
    swal({
      title: "Remove Coupon?",
      text: "Are you sure want to delete the coupon?",
      icon: "warning",
      buttons: [
        'Cancel',
        'Remove'
      ],
      confirmButtonText: "Remove",
      dangerMode: true,
    })
    .then(function(willDelete){
      if (willDelete) {

        $http({
          url : "/ajax/cart",
          params : { response_type: "JSON" },
          data : { data : { discount_code: ""  }, type: "DISCOUNT" },
          method: "POST"
        })
        .then(function(res){
          $scope.is_error = false;
          $rootScope.$broadcast('cart_updated', { any: {} });
        }, function(res){
          $scope.is_error = true;
        });

      }
    });
  }

  $scope.calculateTotal = function() {
    // UPDATE SUB_TOTAL
    $scope.cart.sub_total = _.chain($scope.cart.products).map(function(p){
      return p.product_id.selling_price * p.selected_quantity;
    }).reduce(function(a,b){
      return a+b;
    }).value() || 0;

    if($scope.cart.delivery_data && $scope.cart.delivery_data.delivery_cost) {
      $scope.cart.delivery_charges = $scope.cart.delivery_data.delivery_cost;
    }

    if($scope.cart.sub_total == 0) {
      $scope.cart.delivery_charges = 0;
      $scope.cart.discount_value = 0;
    }

    $scope.cart.total = Math.round(angular.copy($scope.cart.sub_total) + ($scope.cart.delivery_charges || 0) - ($scope.cart.discount_value || 0));

    $scope.cart.tax = Math.round( ($scope.cart.total * 0.05) * 100) / 100;

    $scope.cart.amount_saved = _.chain($scope.cart.products).map(function(p){
      if(p.product_id.compare_at_price)
        return (p.product_id.compare_at_price - p.product_id.selling_price) * p.selected_quantity;
      return 0;
    }).reduce(function(a,b){
      return a+b;
    }).value();
  }

  $scope.loadBestSellers = function() {
    $http({
      url : "/ajax/collections/best_sellers",
      params : { response_type: "JSON" },
      method: "GET"
    })
    .then(function(res){
      var cart_product_ids = _.map($scope.cart.products, function(p){
        return p.product_id._id;
      })
      $scope.best_sellers = _.filter(res.data.product_ids, function(p){
        if(p.product_id && p.product_id['_id'])
          return _.indexOf(cart_product_ids, p.product_id['_id']) == -1;
      }).slice(0, 4);
    })
  }

  $scope.addToCart = function(product_id, quantity, index, variant_id) {

    $http({
      url : "/ajax/cart",
      params : { response_type: "JSON" },
      data : { data : { product_id: product_id, quantity: quantity, selected_product_variant_id: variant_id  }, type: "PRODUCTS" },
      method: "POST"
    })
    .then(function(res){
      if(quantity > 0) {
        //showAddedToCart("Added to Cart");
        cartWrapper.addClass('cart-open');
        setTimeout(function(){
          cartWrapper.removeClass('cart-open');
        }, 5000);
      }
      else if(quantity == 0){
        showAddedToCart("Removed from Cart");
        if(window.product) {
          window.location.reload();
        }
      }
      if($scope.best_sellers.length > 0) {
        var _index = _.findIndex($scope.best_sellers, function(p){
          return p.product_id['_id'] == product_id;
        })
        if(_index > -1) {
          $scope.best_sellers.splice(_index,1)
        }
      }
      $rootScope.$broadcast('cart_updated', { any: {} });
      //$scope.loadCart();
    })
  }

  $scope.showLoadingSpinner = showLoadingSpinner;


  $scope.increment = function(id, quantity, index) {
    quantity = quantity+1;
    $scope.cart.products[index]['selected_quantity'] = quantity;
    $scope.addToCart(id, quantity);
  }

  $scope.decrement = function(id, quantity, index) {
    if(quantity > 1) {
      quantity = quantity-1;
      $scope.cart.products[index]['selected_quantity'] = quantity;
      $scope.addToCart(id, quantity);
    }
    else {
      showLoadingSpinner();
      $scope.removeProduct(id, index);
    }
  }

  $scope.removeProduct = function(id, index) {

    swal({
      title: "Confirm Delete",
      text: "Are you sure want to delete from your cart?",
      icon: "warning",
      buttons: [
        'Cancel',
        'Delete'
      ],
      confirmButtonText: "Delete",
      dangerMode: true,
    })
    .then(function(willDelete){
      if (willDelete) {

        $timeout(function(){
          $scope.cart.products.splice(index, 1);

          if($scope.cart.products.length == 0) {
            toggleCart();
          }
          $scope.addToCart(id,0);
        },50)

      }
    });


  }

  $scope.loadCart = function() {
    $http({
      url : "/ajax/cart",
      params : { response_type: "JSON" },
      method: "GET"
    })
    .then(function(res){
      if(!_.isEmpty(res.data)) {
        $scope.cart = res.data;
        $rootScope.cart_count = $scope.cart.products.length || 0;
        $scope.calculateTotal();
      }
      $("#checkout_container").removeClass('hide');
    })
  };

  $scope.$on('cart_updated', function(event, args) {
    $scope.loadCart();
  });

  $scope.$on('delivery_changed', function(event, args){
    $scope.cart.delivery_charges = args.price;
    $scope.cart.total = angular.copy($scope.cart.sub_total) + $scope.cart.delivery_charges;
  });

})

app.controller('SubscriptionController', function($scope, $http, $rootScope){

})

app.controller('SubscriptionDetailsController', function($scope, $http, $rootScope, $sce){
  $scope.billing_periods = [];
  $scope.current_variant = {};

  $scope.changeVariant = function(variant_id) {
    var variant = _.findWhere(subscription.variants, { _id : variant_id });
    $scope.current_selected_period_id = '';

    if(variant) {
      $scope.billing_periods = variant.billing_period;
    }

  }

  $scope.getAMCTerms = function() {
    $http({
      method : "GET",
      url : "/pages/amc-terms-conditions?response_type=JSON"
    })
    .then(function(res){
      var page = res.data['page'];
      if(page) {
        $scope.amc_terms = $sce.trustAsHtml(page.page_content);
      }
    })
  }

  $scope.getAMCTerms();

  $scope.changeBillingPeriod = function(p) {
    $scope.current_selected_period_id = p._id;
  }

  $scope.proceedToCheckout = function() {
    var is_logged_in = window.localStorage.getItem('user_session_id')
  	if(!is_logged_in) {
  		return $("#loginModal").modal('show');
  	}

    if(!$("#confirm-standard").is(":checked")) {
      return swal("Please Agree to Terms & Conditions", "", "warning");
    }

    showLoadingSpinner("Checking out..");
    window.location.href = "/subscriptions/checkout?subscription_id=" + subscription._id + "&variant_id=" + $scope.current_variant['variant_id'] + "&billing_period_id=" + $scope.current_selected_period_id;
  }

})

app.controller('SubscriptionPaymentController', function($scope, $http, $rootScope, $timeout){
  $scope.subscription = window.subscription;
  $scope.query = window.query;

  $scope.sub_total = 0;
  $scope.total = 0;

  var variant = _.find($scope.subscription.variants, function(v){
    return String(v._id) == String(query.variant_id);
  });

  var billing_period = _.find(variant.billing_period, function(b){
    return String(b._id) == String(query.billing_period_id);
  });

  if(!variant || !billing_period || !billing_period.price) {
    return alert("Invalid Billing Period / Variant");
  }

  $scope.sub_total = billing_period.price;
  $scope.total = billing_period.price;
  $scope.tax = Math.round($scope.total * 0.05);

  var user = JSON.parse(localStorage.getItem('user'));

  $scope.payment_method='ONLINE';

  // GET RZ CREDS
  $http({
    url : '/payment/redirect/checkout',
    params : { response_type: "JSON" },
    method: "GET"
  }).then(function(res){
    $scope.checkout_creds = res.data;
  })

  $scope.authorizePayment = function(id) {
    showLoadingSpinner("Verifying Payment");

    // AUTHORIZING PAYMENT
    var subscription_id = $("#subscription_id").val();
    var variant_id = $("#variant_id").val();
    var billing_period_id = $("#billing_period_id").val();
    var address_id = $("#address_id").val();
    var amount = $scope.total;

    window.location.href="/subscriptions/"+ subscription_id +"/redirect/checkout/callback?token=" + id + "&variant_id=" + variant_id + "&billing_period_id=" + billing_period_id + "&address_id=" + address_id + "&amount=" + amount + "&subscription_id=" + subscription_id;

  }

  $scope.redirectPayment = function(e) {
    if($scope.payment_method == "ONLINE") {
      e.preventDefault();

      var user  = JSON.parse(window.localStorage.getItem('user'));
      var total =   $scope.total;

      Checkout.configure({
        publicKey: $scope.checkout_creds['checkout_key'],
        customerEmail: user.local['email'],
        value: Math.round(total * 100),
        currency: 'AED',
        paymentMode: 'cards',
        cardFormMode: 'cardTokenisation',
        logoUrl : "https://staging.hitchesglitches.com/assets/img/logo/homelogo.png",
        title : "Hitches & Glitches",
        subtitle : "",
        widgetColor : "#F57F28",
        buttonColor:  "#F57F28",
        themeColor: "#F57F28",
        buttonLabelColor : "#FFF",
        theme: 'light',
        cardTokenised: function (event) {
          if(event.data.cardToken) {
            $scope.authorizePayment(event.data.cardToken)
          }
          else {
              return swal("Payment Failed", "Your payment transcation has failed. Please try again.", "error");
          }
        }
      });

      Checkout.open();


    }
    else {
      showLoadingSpinner("Placing Order");
    }
  }

});

app.controller('PaymentRequestPaymentController', function($scope, $http, $rootScope, $timeout, $sce){
  var user = JSON.parse(localStorage.getItem('user'));

  $scope.getServiceTerms = function() {
    $http({
      method : "GET",
      url : "/pages/one-time-service-terms?response_type=JSON"
    })
    .then(function(res){
      var page = res.data['page'];
      if(page) {
        $scope.service_terms = $sce.trustAsHtml(page.page_content);
      }
    })
  }

  $scope.getServiceTerms();

  $scope.payment_method='ONLINE';

  $scope.payment_request = window.payment_request;

  // GET RZ CREDS
  $http({
    url : '/payment/redirect/checkout',
    params : { response_type: "JSON" },
    method: "GET"
  }).then(function(res){
    $scope.checkout_creds = res.data;
  });

  $scope.authorizePayment = function(id) {
    showLoadingSpinner("Verifying Payment");

    // AUTHORIZING PAYMENT
    window.location.href="/payment_requests/pay/redirect/checkout/callback?payment_request_id="+ $scope.payment_request['_id'] +"&token=" + id;

  }

  $scope.redirectPayment = function(e) {

    if(!$("#confirm-standard").is(":checked")) {
      e.preventDefault();
      return swal("Please Agree to Terms & Conditions", "", "warning");
    }

    if($scope.payment_method == "ONLINE") {
      e.preventDefault();

      var user  = JSON.parse(window.localStorage.getItem('user'));
      var total =   $scope.payment_request['amount'];

      Checkout.configure({
        publicKey: $scope.checkout_creds['checkout_key'],
        customerEmail: user.local['email'],
        value: Math.round(total * 100),
        currency: 'AED',
        paymentMode: 'cards',
        cardFormMode: 'cardTokenisation',
        logoUrl : "https://staging.hitchesglitches.com/assets/img/logo/homelogo.png",
        title : "Hitches & Glitches",
        subtitle : "",
        widgetColor : "#F57F28",
        buttonColor:  "#F57F28",
        themeColor: "#F57F28",
        buttonLabelColor : "#FFF",
        theme: 'light',
        cardTokenised: function (event) {
          if(event.data.cardToken) {
            $scope.authorizePayment(event.data.cardToken)
          }
          else {
              return swal("Payment Failed", "Your payment transcation has failed. Please try again.", "error");
          }
        }
      });

      Checkout.open();


    }
  }


})

app.controller('SubscriptionCheckoutController', function($scope, $http, $rootScope, $timeout){
  $scope.subscription = window.subscription;
  $scope.query = window.query;

  $scope.sub_total = 0;
  $scope.total = 0;

  var variant = _.find($scope.subscription.variants, function(v){
    return String(v._id) == String(query.variant_id);
  });

  var billing_period = _.find(variant.billing_period, function(b){
    return String(b._id) == String(query.billing_period_id);
  });

  if(!variant || !billing_period || !billing_period.price) {
    return alert("Invalid Billing Period / Variant");
  }

  $scope.sub_total = billing_period.price;
  $scope.total = billing_period.price;
  $scope.tax = Math.round($scope.total * 0.05);

  var user = JSON.parse(localStorage.getItem('user'));
  $scope.new_address = {
    zip_code: 00000,
    first_name : user.first_name,
    last_name  : user.last_name,
    phone_no   : user.local['phone_no']
  };
  $scope.current_chosen_address = "";
  $scope.all_address = [];
  $scope.current_address = {};

  $scope.openEditAddress = function(a) {
    $scope.current_address = angular.copy(a);
  }

  $scope.updateAddress = function() {
    // Append Custom Area
    var custom_area = $("#custom_area").val();

    if(custom_area) {
      $scope.current_address.locality = custom_area;
    }
    // Merge House No with Street
    var house_no = $("#edit_house_no").val();

    if(house_no) {
      $scope.current_address.street = house_no + " - " + $scope.current_address.street;
    }

    showLoadingSpinner("Updating address");
    $http({
      url : "/ajax/account/address",
      params : { response_type: "JSON" },
      data : { address : $scope.current_address },
      method: "PUT"
    })
    .then(function(res){
      showAddedToCart("Address updated");
      $("#edit_address_modal").modal('hide');
      $scope.all_address = res.data;
    })
  }

  $scope.addMap = function() {
    $timeout(function(){
      $scope.new_address.latitude = $("#latitude").val();
      $scope.new_address.longitude = $("#longitude").val();
      $scope.new_address.street = $('#us2-address').val();
      $scope.map_url = "https://maps.googleapis.com/maps/api/staticmap?center="+ $("#latitude").val() +","+$("#longitude").val()+"&zoom=14&size=400x300&maptype=roadmap&markers=color:red%7Clabel:S%7C"+$("#latitude").val()+","+$("#longitude").val()+"&key=AIzaSyBW9U5EtLg3PyyRpl6NDdfGPixf_hvtZbg"
    },100)
  }

  $scope.validatePhone = function(input) {


    var is_valid = libphonenumber.isValidNumberForRegion(input,"AE");

    if(!is_valid) {
      alert('Please enter Valid Phone Number');
      return false;
    }

    return true;

  }


  $scope.addAddress = function() {
    // Append Custom Area
    var custom_area = $("#custom_area").val();

    if(custom_area) {
      $scope.new_address.locality = custom_area;
    }

    // Merge House No with Street
    var house_no = $("#house_no").val();

    if(house_no) {
      $scope.new_address.street = house_no + " - " + $scope.new_address.street;
    }

    showLoadingSpinner("Adding address");
    $http({
      url : "/ajax/account/address",
      params : { response_type: "JSON" },
      data : { address : $scope.new_address },
      method: "POST"
    })
    .then(function(res){
      showAddedToCart("Address added");
      $("#new_address_modal").modal('hide');
      $scope.all_address = res.data;

      if($scope.all_address && $scope.all_address.length > 0) {
        $timeout(function(){
          var index = $scope.all_address.length - 1;
          $scope.addressChanged($scope.all_address[index]['_id']);
          $("#address_" + index).click();
        },500)
      }

    })
  };

  $scope.deleteAddress = function(id) {
    swal({
      title: "Delete Address",
      text: "Are you sure want to delete this address?",
      icon: "warning",
      buttons: [
        'Cancel',
        'Yes, Delete'
      ],
      dangerMode: true,
      closeOnConfirm : true
    }).then(function(isConfirm) {
      if (isConfirm) {

        showLoadingSpinner("Deleting address");
        $http({
          url : "/ajax/account/address",
          params : { response_type: "JSON", address : id },
          method: "DELETE"
        })
        .then(function(res){
          showAddedToCart("Address Deleted");
          $scope.all_address = res.data;
        })


      }
    })
  }

  $scope.addressChanged = function(id) {
    $scope.current_chosen_address = id;
  }

  $scope.loadAddress = function() {
    $http({
      url : "/ajax/account/address",
      params : { response_type: "JSON" },
      method: "GET"
    })
    .then(function(res){
      $scope.all_address = res.data;
      if($scope.all_address && $scope.all_address.length > 0) {
        $timeout(function(){
          $scope.addressChanged($scope.all_address[0]['_id'])
          $("#address_0").click();
        },1000)
      }
    });
  }

  $scope.loadLocations = function() {
    $http({
      url : "/ajax/store/locations",
      params : { response_type: "JSON" },
      data : { },
      method: "GET"
    })
    .then(function(res){
      $scope.all_locations = res.data['locations'];
    })

  }

  $scope.loadAreas = function(location) {
    var e = _.findWhere($scope.all_locations, { name : location });

    if(e && e.serving_locations && e.serving_locations.length > 0) {
      $scope.allAreas = e.serving_locations;
    }
    else {
      $scope.allAreas = [];
    }

  }

  $scope.proceed = function() {
      var is_logged_in = window.localStorage.getItem('user_session_id')
    	if(!is_logged_in) {
    		return $("#loginModal").modal('show');
    	}
      showLoadingSpinner("Checking out..");
      setTimeout(function(){
        window.location.href = "/subscriptions/payment?subscription_id=" + $scope.query.subscription_id + "&variant_id=" + $scope.query['variant_id'] + "&billing_period_id=" + $scope.query['billing_period_id'] + "&address_id=" + $scope.current_chosen_address;
      },1000);
  }

})

app.controller('AccountSubscriptionDetailsController', function($scope, $http, $rootScope, $timeout){
  $scope.subscription = window.subscription;

  $scope.pbmCategoryChanges = function() {
    var category = $scope.new_callout.problem_category;

    var pbm = _.filter($scope.problem_codes, function(f){
      return f[0] == category;
    });

    $scope.problems = _.map(pbm, function(f){
      return {
        problem : f[1],
        type    : f[2]
      };
    });

  }

  $scope.pbmCodeChanges = function() {

    var category = $scope.new_callout.problem_category;

    var pbm = _.filter($scope.problem_codes, function(f){
      return f[0] == category;
    });
    // GET type
    var problem_type =  _.find(pbm, function(f){
      return f[1] == $scope.new_callout.problem_code;
    });

    if(problem_type) {
      $scope.new_callout.problem_type = problem_type[2];

      setTimeout(function(){
        var min_time;

        if(problem_type[2] == "EMERGENCY") {
           min_time = moment(new Date()).add('30', 'minutes').format('HH');
        }
        else {
           min_time = moment(new Date()).add('120', 'minutes').format('HH');
        }

        $("#time-picker").timepicker({
          defaultTime : min_time
        });
      },100)

    }



  }

  $scope.openSubscriptionProduct = function(applicable_to_id) {

    $scope.new_callout = {};

    $scope.problems = [];

    var applicable_to = _.find($scope.subscription.variant.applicable_to, function(a){
      return String(a._id) == String(applicable_to_id);
    });

    if($scope.payment_requests && $scope.payment_requests.length > 0) {
      return $scope.showPaymentWindow();
    }

    if(applicable_to) {

      if(applicable_to && applicable_to.available_quantity == 0) {
        return swal("Out of Service", "You are out of Services. Please renew the package.", "warning");
      }

      $scope.applicable_to = applicable_to;

      // GET PROBLEM CATEGORY
      _.each($scope.applicable_to.request_fields, function(f){
        if(f.name == "Category") {
          $scope.problem_categories = f.value;
        }
      });

      var pbm_code = _.chain($scope.applicable_to.request_fields).find(function(f){
        return (f.name == "Problem codes");
      }).value();

      $scope.problem_codes = _.map(pbm_code.value, function(f){
        return f.split("-");
      });

      $("#subscription_request_modal").modal('show');

      setTimeout(function(){

        var min_date = new Date();

        var min_time = moment(min_date).add('2', 'hours').format('hh:mm A');

        var current_time = moment(min_date).format('HH');

        // if(current_time > 17) {
        //   min_date = new Date(moment(min_date).add('1','day').startOf('day').format())
        //   min_time = "06:00 AM"
        // }

        // Date picker
        $('#date-picker').datepicker({
            format: "dd/mm/yyyy",
            startDate: min_date,
            endDate : new Date(moment(new Date()).add(7, 'days').format()),
            maxViewMode: 2
        }).on('changeDate', function(e){

        });

        // Time Picker
        // $("#time-picker").timepicker({
        //   defaultTime : min_time
        // });

      },500);

    }
    else {
      return alert("Invalid Request");
    }
  }

  $scope.requestService = function() {
    showLoadingSpinner("Requesting Callout");
    $("#subscription_request_modal").modal('hide');
    var date = $("#date-picker").val();
    date = moment(date, "DD/MM/YYYY").format("YYYY-MM-DD");
    var time = $("#time-picker").val();

    var datetime = moment(date + " " + time, "YYYY-MM-DD hh:mm A");

    var start_time = moment(date + " " + time, "YYYY-MM-DD hh:mm A").format("hh:mm A");

    var delivery_data = {};
    delivery_data['start_time'] = start_time;
    delivery_data['end_time'] = datetime.add("2", "hours").format("hh:mm A");
    delivery_data['day']  = moment(date, "YYYY-MM-DD").format('dddd').toUpperCase();

    var delivery_date = date;

    var variant_id = "";

    if($scope.applicable_to['product_id']['product_variants'] && $scope.applicable_to['product_id']['product_variants'][0]) {
      variant_id = $scope.applicable_to['product_id']['product_variants'][0]['_id'];
    }

    var request_fields = _.map($scope.new_callout, function(val, key){
      return {
        name : key.replace("_", " "),
        value : val
      }
    })

    var data_to_send = {
      customer_subscription_id : window.subscription['_id'],
      product_id    : $scope.applicable_to['product_id']['_id'],
      variant_id    : variant_id,
      delivery_date : delivery_date,
      delivery_data : delivery_data,
      request_fields: request_fields,
      response_type : "JSON"
    }

    // MAKE HTTP REQUEST
    $http({
      url : "/account/subscriptions/" + window.subscription['_id'] + "/request",
      method: "POST",
      data : data_to_send
    })
    .then(function(res){
      if(res.data && res.data['order_id']) {
        window.location.href = "/order_placed/" + res.data['order_id']
      }
    })

  }

  $scope.showPaymentWindow = function() {
    // SHOW BLOCKER TO PAY
    var amount = $scope.payment_requests[0]['amount'];

    if(amount > 0) {
      swal({
        title : 'Pending Payment of AED ' +  amount,
        text : 'You have a pending payment of AED '+ amount +' for this Package. Please pay to proceed.',
        icon : 'warning',
        button: "Pay Now"
      })
      .then(function(c){
        // Redirect to Payment Request
        if(c) {
          window.location.href = "/payment_requests/pay/" + $scope.payment_requests[0]['_id'];
        }
      })
    }
  }

  // CHECK IF ANY PAYMENT REQUESTS ARE OUTSTANDING
  $scope.getPaymentRequests = function() {

    $http({
      url : "/ajax/payment_requests",
      params : {
        "response_type": "JSON",
        "filter.status" : "AWAIT_PAYMENT",
        "filter.customer_subscription_id" : $scope.subscription["_id"]
      },
      method: "GET"
    })
    .then(function(res){
      $scope.payment_requests = res.data;

      if($scope.payment_requests && $scope.payment_requests.length > 0) {
        $scope.showPaymentWindow();
      }

    });

  }


});

app.controller('ProductDetailsController', function($scope, $http, $rootScope, $timeout){

    // INIT RATING
    $("#rating").raty({ starType: 'i' });
    $("#overall-review").circleProgress({
      startAngle: -Math.PI / 2,
      value: 0.8,
      animation: false,
      lineCap: 'round',
      fill: {gradient: ['#F57F28', '#F57F25']}
    });

    $scope.delivery_data = {};

    $scope.loadTimes = function() {
      $scope.show_time_picker = true;
      /* GENERATE TIMES BETWEEN THE RANGE */
      var start_time = moment("09:00 AM","hh:mm A");
      var end_time   = moment("06:00 PM","hh:mm A");

      var times = [];
      times.push(start_time.format('hh:mm A'));
      while(start_time < end_time) {
        start_time = start_time.add(30, 'minutes');
        //var t = start_time.add(30, 'minutes').format('hh:mm A')
        times.push(start_time.format('hh:mm A'));

      }
      //times.push(end_time.format('hh:mm A'));

      $scope.times = times;
    }

    /* CHECK IF ENQUIRE NOW IS FOUND */
    var p = window.product;
    $scope.enquire_now = false;
    $scope.auto_allocation = true;

    _.each(p.product_meta_datas, function(m){
      if(m.product_meta_name == "enquire_now" && m.product_meta_value == "true") {
        $scope.enquire_now = true;
      }

      if(m.product_meta_name == "auto_allocate") {
        if(m.product_meta_value == "true") {
          $scope.auto_allocation = true;
        }
        else {
          $scope.auto_allocation = false;
          $scope.loadTimes();
        }
      }

      if(m.product_meta_name == "show_qty" && m.product_meta_value == "true") {
        $scope.show_qty = true;
        // Update Delivery date & Slot
        var delivery_date = moment(new Date());
        $scope.delivery_date = delivery_date.format('DD/MM/YYYY');
        $scope.delivery_data = {
          start_time: "09:00 AM",
          end_time: "06:00 PM",
          type : "EXPRESS",
          day: delivery_date.format('dddd').toUpperCase()
        }
        $scope.delivery_day  = delivery_date.format('dddd').toUpperCase();
      }

    })


    $scope.enquireNow = function() {
      window.location.href = "/pages/contact-us";
    }

    $scope.quantity = 1;
    $scope.already_added = false;

    $scope.addQuantity = function() {
      $scope.quantity += 1;
    }

    $scope.deductQuantity = function() {
      if($scope.quantity > 0) {
        $scope.quantity -= 1;
      }
    }

    $scope.selectTime = function(time) {
      $scope.selected_time = time;
      $scope.delivery_date = $scope.chosen_date;
      $scope.delivery_data = {
        start_time: time,
        end_time: moment(time, "hh:mm A").add(2, 'hours').format('hh:mm A'),
        type : "SCHEDULED",
        day: $scope.chosen_day
      }
      $scope.delivery_day  = $scope.chosen_day;
    }

    $scope.bookAnyway = function(product_id, quantity, variant_id) {
      var format = 'hh:mm:ss'

      var time = moment(new Date(),format),
          beforeTime = moment('09:00:00', format),
          afterTime = moment('18:00:00', format);
      //
      // if (!time.isBetween(beforeTime, afterTime)) {
      //   return swal("Choose a different ", "Please choose a different service date & slot", "warning");
      // }

      swal({
        title: "Book anyway?",
        text: "Are you sure want to book on this date?",
        icon: "warning",
        buttons: [
          'Cancel',
          'Yes, Book'
        ],
        dangerMode: true,
        closeOnConfirm : true
      }).then(function(isConfirm) {
        // BOOK THE DATE
        var delivery_date = moment(new Date());
        $scope.delivery_date = delivery_date.format('DD/MM/YYYY');
        $scope.delivery_data = {
          start_time: "09:00 AM",
          end_time: "06:00 PM",
          type : "EXPRESS",
          day: delivery_date.format('dddd').toUpperCase()
        }
        $scope.delivery_day  = delivery_date.format('dddd').toUpperCase();
        $scope.addToCart(product_id, quantity, variant_id)
      });
    }

    $scope.loadCart = function() {
      $http({
        url : "/ajax/cart",
        params : { response_type: "JSON" },
        method: "GET"
      })
      .then(function(res){
        $scope.cart = res.data;
        var is_found = _.findIndex($scope.cart.products, function(p){
          return p.product_id['_id'] == $scope.product_id;
        });
        if(is_found > -1) {
          $scope.quantity = $scope.cart.products[is_found]['selected_quantity'];
          $scope.already_added = true;

          if($scope.cart.products[is_found]['delivery_date']) {
            $("#range-calendar").datepicker("update", new Date($scope.cart.products[is_found]['delivery_date']));

            $scope.chosen_date = moment($scope.cart.products[is_found]['delivery_date']).format('DD/MM/YYYY');
            $scope.chosen_day = $scope.cart.products[is_found]['delivery_data']['day'];
            $scope.getAvailableSlots($scope.chosen_day);

            var slots = $scope.available_slots.slots;

            $scope.current_slot = _.find(slots, function(s){
              return (s.start_time == $scope.cart.products[is_found]['delivery_data']['start_time']) && (s.end_time == $scope.cart.products[is_found]['delivery_data']['end_time'])
            });

            $timeout(function(){
              $scope.deliverySlotChanged($scope.chosen_date,$scope.current_slot,$scope.chosen_day )
            },500)

          }

        }
      })
    }

    $scope.addToCart = function(product_id, quantity, variant_id) {

      if(!$scope.delivery_date || !$scope.delivery_data || !$scope.delivery_data.start_time) {
        return swal("Missing Service Date / Slot", "Please choose a service date & slot", "warning");
      }

      $scope.delivery_data.day = angular.copy($scope.delivery_day)
      var date = moment( $scope.delivery_date, "DD/MM/YYYY").format('YYYY-MM-DD');


      $http({
        url : "/ajax/cart",
        params : { response_type: "JSON" },
        data : {
          data : {
            product_id: product_id,
            quantity: quantity,
            selected_product_variant_id: variant_id,
            delivery_date : date,
            delivery_data : $scope.delivery_data
          },
          type: "PRODUCTS" },
        method: "POST"
      })
      .then(function(){
        is_loading = false;
        showAddedToCart("Added to Cart");
        $rootScope.$broadcast('cart_updated', { any: {} });
        $scope.already_added = true;
        cartWrapper.addClass('cart-open');
      })
    }

    // DELIVERY DATE
    $scope.getAvailableSlots = function(day, date) {

      $scope.all_slots = [];

      $scope.available_slots = {};

      var current_variant = _.chain($scope.current_variant).values().first().value();

      var _v = _.find(window.product.product_variants, function(v){
        return v._id == current_variant.variant_id;
      });

      var v = angular.copy(_v);

      // GET AVAILABLE SLOTS

      // GET AVAILABLE SLOTS FROM BACKEND
      showLoadingSpinner("Loading available Slots..")

      $http({
        method: "GET",
        url : window.base_url + "/api/customer/store/delivery_slot/check_validity",
        params : {
          product_id : window.product['_id'],
          product_variant_id : _v['_id'],
          store_id : window.store_id,
          locality : localStorage.getItem('area'),
          date : moment(date, "DD/MM/YYYY").format("YYYY-MM-DD")
        }
      })
      .then(function(res){

        overlay.hide();

        var data = res.data['slots'];

        v.slots = data;

        // var entry = _.filter(data, function(s){
        //   console.log(s)
        //   return s.is_active;
        // });

        var entry = [
          data
        ]

        if(entry.length > 0 && entry[0]) {
          entry[0].day = day;
          // FILTER OUT UNAVAILABLE SLOTS IF DATE IS TODAY
          if(date) {
            var correct_slots = [];

            _.each( entry[0][ 'slots' ], function( slot, index ) {
              if ( slot && slot[ 'is_active' ] && slot['is_available']) {
                var cut_off_time = moment( slot[ 'cutoff_time' ], 'hh:mm A' ).format();
                var current_time = moment( new Date() ).format();

                if(date != moment(new Date()).format('DD/MM/YYYY')) {
                  correct_slots.push( slot );
                }

                if ( date == moment(new Date()).format('DD/MM/YYYY') && (current_time < cut_off_time)) {
                  correct_slots.push( slot );
                }

              }

            } );

            entry[0][ 'slots' ] = correct_slots;
          }

          $scope.available_slots = entry[0];
        }

      });
    }

    $scope.deliverySlotChanged = function(date, slot, day) {
      if(date && slot) {
        $scope.delivery_date = date;
        $scope.delivery_data = slot;
        $scope.delivery_data['type'] = "SCHEDULED";
        $scope.delivery_day  = day;
        $(".slot-btn").removeClass('active');
        $("#"+slot._id).addClass('active');
      }
    }


    // INIT PLUGIN
    var start_date = new Date(moment().format())

    // IF AUTO ALLOCATE IS TRUE && CURRENT TIME IS > 6PM, show next day
    if($scope.auto_allocation && moment(new Date()).isAfter(moment("06:00 PM", "hh:mm A"))) {
      start_date = new Date(moment().add(1, 'days').format());
    }

    // IF AUTO ALLOCATE IS FALSE && CURRENT TIME IS > 4PM, show next day
    if(!$scope.auto_allocation && moment(new Date()).isAfter(moment("04:00 PM", "hh:mm A"))) {
      start_date = new Date(moment().add(1, 'days').format());
    }

    var end_date = new Date(moment().add(3, 'months').format())

    $("#delivery_slots").removeClass('hide');

    $('#range-calendar').datepicker({
        format: "dd/mm/yyyy",
        startDate: start_date,
        endDate : end_date,
        maxViewMode: 2,
        daysOfWeekDisabled: "5"
    }).on('changeDate', function(e){
        $timeout(function(){
          $scope.chosen_date = moment(e.date).format('DD/MM/YYYY');
          $scope.chosen_day = moment(e.date).format('dddd').toUpperCase();

          if($scope.auto_allocation) {
            $scope.getAvailableSlots($scope.chosen_day, $scope.chosen_date);
          }
          else {
            $scope.loadTimes();
          }


        },0);
    });

    $scope.variantChanged = function() {

      if($scope.auto_allocation) {
        $scope.getAvailableSlots($scope.chosen_day, $scope.chosen_date);
        $scope.delivery_data = {};
      }
      else {
        $scope.loadTimes();
      }
    }

    // LOAD CART
    $scope.loadCart();

});

app.controller('CheckoutController', function($scope, $http, $timeout){
  var user = JSON.parse(localStorage.getItem('user'));

  $scope.new_address = {
    first_name : user.first_name,
    last_name  : user.last_name,
    phone_no   : user.local['phone_no']
  };

  $scope.current_chosen_address = "";
  $scope.all_address = [];
  $scope.current_address = {};

  $scope.openEditAddress = function(a) {
    $scope.current_address = angular.copy(a);
    $scope.map_url = ""
  }

  $scope.updateAddress = function() {
    // Append Custom Area
    var custom_area = $("#custom_area").val();

    if(custom_area) {
      $scope.current_address.locality = custom_area;
    }

    // Merge House No with Street
    var house_no = $("#edit_house_no").val();

    if(house_no) {
      $scope.current_address.street = house_no + " - " + $scope.current_address.street;
    }

    showLoadingSpinner("Updating address");
    $http({
      url : "/ajax/account/address",
      params : { response_type: "JSON" },
      data : { address : $scope.current_address },
      method: "PUT"
    })
    .then(function(res){
      showAddedToCart("Address updated");
      $("#edit_address_modal").modal('hide');
      $scope.all_address = res.data;
    })
  }

  $scope.addMap = function(latitude, longitude) {

    // CHECK IF EDIT ADDRESS IS OPENED
    if(($("#edit_address_modal").data('bs.modal') || {}).isShown) {
      $timeout(function(){
        $scope.current_address.latitude = $("#latitude").val();
        $scope.current_address.longitude = $("#longitude").val();
        if($scope.current_address.latitude && $scope.current_address.longitude) {
          $scope.map_url = "https://maps.googleapis.com/maps/api/staticmap?center="+ $scope.current_address.latitude +","+$scope.current_address.longitude+"&zoom=14&size=400x300&maptype=roadmap&markers=color:red%7Clabel:S%7C"+$scope.current_address.latitude+","+$scope.current_address.longitude+"&key=AIzaSyBW9U5EtLg3PyyRpl6NDdfGPixf_hvtZbg"
        }
      },100)
    }
    else {
      $timeout(function(){
        $scope.new_address.latitude = latitude || $("#latitude").val();
        $scope.new_address.longitude = longitude || $("#longitude").val();
        if(!$scope.is_added_by_autocomplete) {
          $scope.new_address.street = $('#us2-address').val();
          $scope.is_added_by_autocomplete = false;
        }
        $scope.map_url = "https://maps.googleapis.com/maps/api/staticmap?center="+ $scope.new_address.latitude +","+$scope.new_address.longitude+"&zoom=14&size=400x300&maptype=roadmap&markers=color:red%7Clabel:S%7C"+$scope.new_address.latitude+","+$scope.new_address.longitude+"&key=AIzaSyBW9U5EtLg3PyyRpl6NDdfGPixf_hvtZbg"
      },100)
    }


  }

  $scope.placeChanged = function() {

    var place = this.getPlace();
    var latitude = place.geometry.location.lat();
    var longitude = place.geometry.location.lng();
    $("#latitude").val(latitude);
    $("#longitude").val(longitude);
    if($scope.new_address.street) {
      $scope.is_added_by_autocomplete = true;
      $("#us2-address").val($scope.new_address.street)
    }
    $scope.addMap(latitude, longitude);
  }

  $scope.validatePhone = function(input) {

    var is_valid = libphonenumber.isValidNumberForRegion(String(input),"AE");

    if(!is_valid) {
      alert('Please enter Valid Phone Number');
      return false;
    }

    return true;

  }


  $scope.addAddress = function() {

    // Append Custom Area
    var custom_area = $("#custom_area").val();

    if(custom_area) {
      $scope.new_address.locality = custom_area;
    }

    // Merge House No with Street
    var house_no = $("#house_no").val();

    if(house_no) {
      $scope.new_address.street = house_no + " - " + $scope.new_address.street;
    }

    showLoadingSpinner("Adding address");
    $http({
      url : "/ajax/account/address",
      params : { response_type: "JSON" },
      data : { address : $scope.new_address },
      method: "POST"
    })
    .then(function(res){
      showAddedToCart("Address added");
      $("#new_address_modal").modal('hide');
      $scope.all_address = res.data;

      /* CHECK IF ADDRESS ALREADY EXISTS */
      if(!$scope.new_address.phone_no && $scope.all_address.length > 0) {
        // GET FIRST PHONE NO
        var p = $scope.all_address[0]['phone_no'] || "";
        $scope.new_address.phone_no = p;
      }

      if($scope.all_address && $scope.all_address.length > 0) {
        $timeout(function(){
          var index = $scope.all_address.length - 1;
          $scope.addressChanged($scope.all_address[index]['_id']);
          $("#address_" + index).click();
        },500);
      }

    })
  };

  $scope.deleteAddress = function(id) {
    swal({
      title: "Delete Address",
      text: "Are you sure want to delete this address?",
      icon: "warning",
      buttons: [
        'Cancel',
        'Yes, Delete'
      ],
      dangerMode: true,
      closeOnConfirm : true
    }).then(function(isConfirm) {
      if (isConfirm) {

        showLoadingSpinner("Deleting address");
        $http({
          url : "/ajax/account/address",
          params : { response_type: "JSON", address : id },
          method: "DELETE"
        })
        .then(function(res){
          showAddedToCart("Address Deleted");
          $scope.all_address = res.data;
        })


      }
    })
  }

  $scope.addressChanged = function(id, index) {
    $scope.current_chosen_address = id;

        // CHECK IF THE ADDRESS CHOSEN IS WITHIN AREA
        var address =   _.find($scope.all_address, function(a) {
                          return String(a._id) == String(id);
                        });

        var area = localStorage.getItem('area');

        localStorage.setItem('last_address', id);

        if(area && address) {
          if(address.locality != area) {
            // Show Swal
            swal({
              title: "Different Area",
              text: "The Address you have chosen is different from the selected area. Do you want to clear your cart & change your area?",
              icon: "warning",
              buttons: [
                'Choose different address',
                'Clear Cart & start fresh'
              ],
              dangerMode: true,
              closeOnConfirm : true
            }).then(function(isConfirm) {
              if(!isConfirm) {
                $scope.current_chosen_address = "";
                $('#address_' + index).attr('checked',false);
              }
              else {
                localStorage.setItem('area', '');
                window.location.href = "/";
              }
            })

          }
        }
  }

  $scope.loadAddress = function() {
    $http({
      url : "/ajax/account/address",
      params : { response_type: "JSON" },
      method: "GET"
    })
    .then(function(res){
      $scope.all_address = res.data;
      if($scope.all_address && $scope.all_address.length > 0) {
        $timeout(function(){
          // Find the address that has the area chosen
          var area = localStorage.getItem('area');
          var last_address = localStorage.getItem('last_address');

          if(last_address) {
            var index =   _.findIndex($scope.all_address, function(a) {
                              return String(a._id) == String(last_address);
                            });
            if(index > -1) {
              $scope.addressChanged($scope.all_address[index]['_id'])
              $("#address_"+index).click();
            }
            else {
              $scope.addressChanged($scope.all_address[0]['_id'])
              $("#address_0").click();
            }
          }

          else if(area) {
            var index =   _.findIndex($scope.all_address, function(a) {
                              return String(a.locality) == String(area);
                            });
            if(index > -1) {
              $scope.addressChanged($scope.all_address[index]['_id'])
              $("#address_"+index).click();
            }
            else {
              $scope.addressChanged($scope.all_address[0]['_id'])
              $("#address_0").click();
            }
          }
          else {
            $scope.addressChanged($scope.all_address[0]['_id'])
            $("#address_0").click();
          }




        },1000)
      }
    });
  }

  $scope.loadLocations = function() {
    $http({
      url : "/ajax/store/locations",
      params : { response_type: "JSON" },
      data : { },
      method: "GET"
    })
    .then(function(res){
      $scope.all_locations = res.data['locations'];
    })

  }

  $scope.loadAreas = function(location) {
    var e = _.findWhere($scope.all_locations, { name : location });

    if(e && e.serving_locations && e.serving_locations.length > 0) {
      $scope.allAreas = e.serving_locations;
    }
    else {
      $scope.allAreas = [];
    }

  }

  $scope.proceed = function() {
    if(!$scope.current_chosen_address) {
      return swal("Please select a different address", "", "warning");
    }
    $http({
      url : "/ajax/cart",
      params : { response_type: "JSON" },
      data : { data : { address : $scope.current_chosen_address }, type: "ADDRESS" },
      method: "POST"
    })
    .then(function(res){
      window.location.href="/cart/payment";
    }, function(){
      return alert("Invalid Address")
    })
  }

})

app.controller('DeliveryController', function($scope, $http, $rootScope, $timeout){
  $scope.delivery_date = "";
  $scope.delivery_type = "";
  $scope.delivery_data = {};
  /* LOAD DELIVERY SLOTS */
  $scope.loadDeliveryTypes = function() {
    $http( {
        url: "/ajax/store/delivery_type",
        params: { response_type: "JSON" },
        method: "GET"
      } )
      .then(function(res) {
        window.localStorage.setItem('delivery_type', JSON.stringify(res.data));

        var express = _.find( res.data, function( d, index ) { return d.type == "EXPRESS" } )
        var scheduled = _.find( res.data, function( d, index ) { return d.type == "SCHEDULED" } )

        $scope.delivery_type = res.data;


        $scope.all_delivery_types = _.filter($scope.delivery_type, function(type){
          if(type.from_time && type.to_time) {
            var check_from_time = moment(type.from_time, "h:mm A");
            var check_to_time 	= moment(type.to_time, "h:mm A");
            if(!moment().isAfter( check_to_time) && moment().isAfter(check_from_time)  ) {
              return true;
            }
            return false;
          }
          else {
            return true;
          }
        });

      })
  }
  $scope.loadDeliverySlots = function() {
		$http( {
				url: "/ajax/store/delivery_slots",
				params: { response_type: "JSON" },
				method: "GET"
			} )
			.then( function( res ) {
				var data = res.data;
        $scope.all_slots = data;
				$scope.dates = [];
				$scope.isDateSelected = [];

				/* GENERATE DATES */
				var i = 0,
					j = 1;
				var current_time = moment( new Date )
				var check_time = current_time.hour( 17 ).minute( 30 );

				if ( !moment().isAfter( check_time ) ) {
					j = 0;
				}
				while ( i < 3 ) {
					var tmp = moment( new Date ).add( j, 'days' );
					var d = _.findWhere( data, { day: tmp.format( "dddd" ).toUpperCase() } ) || {};

					if ( d.is_active && tmp.format( 'DD/MM/YYYY' ) == moment( new Date() ).format( 'DD/MM/YYYY' ) ) {

						var correct_slots = [];

						_.each( d[ 'slots' ], function( slot, index ) {
							if ( slot && slot[ 'is_active' ] ) {
								var cut_off_time = moment( slot[ 'cutoff_time' ], 'hh:mm A' ).format();
								var current_time = moment( new Date() ).format();

								if ( current_time < cut_off_time ) {
									correct_slots.push( slot );
								}
							}

						} );

						d[ 'slots' ] = correct_slots;

					}

					if ( d.is_active ) {
						$scope.dates.push( {
							date: tmp.format( 'DD/MM/YYYY' ),
							day: d.day,
							slot: _.filter( d[ 'slots' ], function( f ) { return f.is_active } )
						} );
						$scope.isDateSelected.push( false );
					}

					i++;
					j++;
				}

        $( "#delivery_label, #delivery_slots, .proceed-to-checkout" ).removeClass( 'hide' );


			} );
	}

  $scope.getAvailableSlots = function(day) {
    var entry = _.filter($scope.all_slots, function(s){
      return s.is_active && s.day == day;
    });
    if(entry.length > 0) {
      entry[0].day = day;
      return entry[0];
    }
    return {};
  }

  $scope.deliveryTypeChanged = function( type, price, cutoff ) {
    $scope.delivery_type = type;
    // TOTAL CART
    var sub_total_amount = $( "#sub_total_amount" ).data( 'value' );
    if ( type == "EXPRESS" ) {
      $scope.delivery_date = moment( new Date() ).format( 'DD/MM/YYYY' );
      $scope.delivery_day = moment(new Date()).format('dddd')
      $scope.show_proceed_btn = true;
    }
    if ( type == "SCHEDULED" ) {

      // INIT PLUGIN
      var start_date = new Date(moment().add(1, 'days').format())
      var end_date = new Date(moment().add(3, 'months').format())

      $('#range-calendar').datepicker({
          format: "dd/mm/yyyy",
          startDate: start_date,
          endDate : end_date,
          maxViewMode: 2,
          daysOfWeekDisabled: "5"
      }).on('changeDate', function(e){
        console.log(e.date)
          $timeout(function(){
            $scope.chosen_date = moment(e.date).format('DD/MM/YYYY');
            $scope.chosen_day = moment(e.date).format('dddd').toUpperCase();
            $scope.available_slots = $scope.getAvailableSlots($scope.chosen_day);
          },0);
      })

      // var rangeCalendar = $("#range-calendar").rangeCalendar({
      //   startDate : start_date,
      //   endDate : end_date,
      //   minRangeWidth : 1,
      //   maxRangeWidth : 1,
      //   start : "+0",
      //   changeRangeCallback : function(target, range) {
      //     var s = range['start'];
      //     var day = moment(new Date(s)).add(1, 'days');
      //     $timeout(function(){
      //       $scope.chosen_date = day.format('DD/MM/YYYY');
      //       $scope.chosen_day = day.format('dddd').toUpperCase();
      //       $scope.available_slots = $scope.getAvailableSlots($scope.chosen_day);
      //     },0);
      //
      //   }
      // });
      //
      // rangeCalendar.setStartDate(start_date);

      // CHOOSE FIRST DATE
      //$scope.deliverySlotChanged( $scope.dates[ 0 ][ 'date' ], $scope.dates[ 0 ][ 'slot' ][ 0 ], $scope.dates[ 0 ][ 'day' ] )
    }
    if ( sub_total_amount > cutoff ) {
      $scope.delivery_cost = 0;
    } else {
      $scope.delivery_cost = price;
    }
    $rootScope.$broadcast( 'delivery_changed', { type: type, price : $scope.delivery_cost } );
  }


  $scope.deliverySlotChanged = function(date, slot, day) {
    $scope.delivery_date = date;
    $scope.delivery_data = slot;
    $scope.delivery_day  = day;
    $(".slot-btn").removeClass('active');
    $("#"+slot._id).addClass('active');
  }

  $scope.saveDeliveryMethod = function() {
    $http({
      url : "/ajax/cart",
      params : { response_type: "JSON" },
      data : {
        data : {
          delivery : {
            type : $scope.delivery_type,
            date : moment($scope.delivery_date, "DD/MM/YYYY").format(),
            day  : $scope.delivery_day.toUpperCase(),
            start_time : $scope.delivery_data['start_time'],
            end_time : $scope.delivery_data['end_time'],
            delivery_cost : $scope.delivery_cost
          }
        },
        type: "DELIVERY"
      },
      method: "POST"
    })
  }

  $scope.proceed = function() {
    $http({
      url : "/ajax/cart",
      params : { response_type: "JSON" },
      data : {
        data : {
          delivery : {
            type : $scope.delivery_type,
            date : moment($scope.delivery_date, "DD/MM/YYYY").format(),
            day  : $scope.delivery_day.toUpperCase(),
            start_time : $scope.delivery_data['start_time'],
            end_time : $scope.delivery_data['end_time'],
            delivery_cost : $scope.delivery_cost
          }
        },
        type: "DELIVERY"
      },
      method: "POST"
    })
    .then(function(res){
      window.location.href="/cart/payment";
    }, function(){
      return alert("Invalid Delivery Options")
    })
  }

})

app.controller('DiscountController', function($scope, $http, $rootScope){

  $scope.discount_code = "";

  $scope.applyDiscount = function() {
    if($scope.discount_code) {
      $scope.discount_code = $scope.discount_code.toUpperCase();
    }
    $http({
      url : "/ajax/cart",
      params : { response_type: "JSON" },
      data : { data : { discount_code: $scope.discount_code  }, type: "DISCOUNT" },
      method: "POST"
    })
    .then(function(res){
      $scope.is_error = false;
      $rootScope.$broadcast('cart_updated', { any: {} });
      $("#discount_container").modal('hide');
    }, function(res){
      $scope.is_error = true;
    })
  }

});

app.controller('OrderDetailsController', function($scope, $http){

  $scope.showPaymentWindow = function() {
    // SHOW BLOCKER TO PAY
    var amount = $scope.payment_requests[0]['amount'];

    var msg = "";

    if($scope.payment_requests[0]['order_id']) {
      msg = "for your order"
    }

    if($scope.payment_requests[0]['customer_subscription_id']) {
      msg = "for your package"
    }


    if(amount > 0) {
      swal({
        title : 'Pending Payment of AED ' +  amount,
        text : 'You have a pending payment of AED '+ amount + " " + msg,
        icon : 'warning',
        button: "Pay Now"
      })
      .then(function(c){
        // Redirect to Payment Request
        if(c) {
          window.location.href = "/payment_requests/pay/" + $scope.payment_requests[0]['_id'];
        }
      })
    }
  }

  // CHECK IF ANY PAYMENT REQUESTS ARE OUTSTANDING
  $scope.checkPendingPayment = function(order_id) {

    $http({
      url : "/ajax/payment_requests",
      params : {
        "response_type": "JSON",
        "filter.status" : "AWAIT_PAYMENT",
        "filter.order_id" : order_id
      },
      method: "GET"
    })
    .then(function(res){
      $scope.payment_requests = res.data;

      if($scope.payment_requests && $scope.payment_requests.length > 0) {
        $scope.showPaymentWindow();
      }

    });
  }





})

app.controller('PaymentController', function($scope, $http, $sce){
  $scope.payment_method='ONLINE';

  var baseRequest = {
    apiVersion: 2,
    apiVersionMinor: 0
  };

  var allowedCardNetworks = ["AMEX", "DISCOVER", "INTERAC", "JCB", "MASTERCARD", "VISA"];
  var allowedCardAuthMethods = ["PAN_ONLY", "CRYPTOGRAM_3DS"];

  var baseCardPaymentMethod = {
    type: 'CARD',
    parameters: {
      allowedAuthMethods: allowedCardAuthMethods,
      allowedCardNetworks: allowedCardNetworks
    }
  };

  var paymentsClient = new google.payments.api.PaymentsClient({environment: 'PRODUCTION'});

  var isReadyToPayRequest = Object.assign({}, baseRequest);
  isReadyToPayRequest.allowedPaymentMethods = [baseCardPaymentMethod];

  var customer = localStorage.getItem('user');

  $scope.enable_cod = false;

  if(customer) {
    customer = JSON.parse(customer);

    _.each(customer.custom_fields, function(c){
      if(c.name == "cod_enabled" && c.value == "true") {
        $scope.enable_cod = true;
      }
    })

  }


  $scope.getServiceTerms = function() {
    $http({
      method : "GET",
      url : "/pages/one-time-service-terms?response_type=JSON"
    })
    .then(function(res){
      var page = res.data['page'];
      if(page) {
        $scope.service_terms = $sce.trustAsHtml(page.page_content);
      }
    })
  }

  $scope.getServiceTerms();

  // GET RZ CREDS
  $http({
    url : '/payment/redirect/checkout',
    params : { response_type: "JSON" },
    method: "GET"
  }).then(function(res){
    $scope.checkout_creds = res.data;
    $scope.cart_total =   $scope.checkout_creds['cart_total'];

    // Check if Wallet is allowed
    if(window.allowed_points && window.allowed_points > 0) {
      if(window.allowed_points >= $scope.cart_total ) {
        $scope.enable_wallet = true;
      }
      else {
        $scope.enable_wallet = false;
      }
    }

  })

  $scope.authorizePayment = function(id) {
    showLoadingSpinner("Verifying Payment");

    // AUTHORIZING PAYMENT
    window.location.href="/payment/redirect/checkout/callback?token=" + id;
    console.log(paymentData);
    paymentToken = paymentData.paymentMethodData.tokenizationData.token;

  }

  $scope.processGooglePayment = function(paymentData) {

  }

  $scope.redirectPayment = function(e) {

    if(!$("#confirm-standard").is(":checked")) {
      e.preventDefault();
      return swal("Please Agree to Terms & Conditions", "", "warning");
    }

    if($scope.payment_method == "ONLINE") {
      e.preventDefault();

      var user  = JSON.parse(window.localStorage.getItem('user'));
      var total =   $scope.checkout_creds['cart_total']

      Checkout.configure({
        publicKey: $scope.checkout_creds['checkout_key'],
        customerEmail: user.local['email'],
        value: Math.round(total * 100),
        currency: 'AED',
        paymentMode: 'cards',
        cardFormMode: 'cardTokenisation',
        logoUrl : "https://staging.hitchesglitches.com/assets/img/logo/homelogo.png",
        title : "Hitches & Glitches",
        subtitle : "",
        widgetColor : "#F57F28",
        buttonColor:  "#F57F28",
        themeColor: "#F57F28",
        buttonLabelColor : "#FFF",
        theme: 'light',
        cardTokenised: function (event) {
          if(event.data.cardToken) {
            $scope.authorizePayment(event.data.cardToken)
          }
          else {
              return swal("Payment Failed", "Your payment transcation has failed. Please try again.", "error");
          }
        }
      });

      Checkout.open();
    }
    else if($scope.payment_method == "GOOGLE_PAY") {

      e.preventDefault();


        var cardPaymentMethod = Object.assign(
          {tokenizationSpecification: tokenizationSpecification},
          baseCardPaymentMethod
        );


    var tokenizationSpecification = {
         type: 'PAYMENT_GATEWAY',
         parameters: {
           'gateway': 'checkoutltd',
           'gatewayMerchantId': $scope.checkout_creds['checkout_key']
         }
        };

      var user  = JSON.parse(window.localStorage.getItem('user'));
      var total =   $scope.checkout_creds['cart_total']

      var paymentDataRequest = Object.assign({}, baseRequest);
      paymentDataRequest.allowedPaymentMethods = [cardPaymentMethod];
      paymentDataRequest.transactionInfo = {
        totalPriceStatus: 'FINAL',
        totalPrice: Math.round($scope.checkout_creds['cart_total']),
        currencyCode: 'AED',
        countryCode: 'UAE'
      };
      paymentDataRequest.merchantInfo = {
        merchantName: 'FARNEK SERVICES LLC',
        merchantId: '11880659516060085064'
      };


      paymentsClient.loadPaymentData(paymentDataRequest)
          .then(function(paymentData) {
            // handle the response
            $scope.processGooglePayment(paymentData);
          })
          .catch(function(err) {
            // show error in developer console for debugging
            console.error(err);
          });


    }



  }

});

app.controller('OrderController', function($scope, $http, $timeout){

  $scope.active_tab = "ORDERS";

  $scope.formatDate = function(d) {
    return moment(d).format("DD/MM/YYYY");
  }

  $scope.changeTab = function(type) {
    $scope.active_tab = type;

    if(type == "SUBSCRIPTIONS") {
      $scope.getSubscriptions();
    }

  }

  $scope.getSubscriptions = function() {
     if(!$scope.subscriptions) {
       showLoadingSpinner("Loading..")
       $http({
         url : "/ajax/account/subscriptions?response_type=JSON",
         method: "GET"
       })
       .then(function(res){
         $scope.subscriptions = res.data;
         overlay.hide();
       })
     }
  }

  $scope.trackLocation = function(order_id) {
    showLoadingSpinner("Loading..")
    $scope.employee_location = [];
    $scope.map_center = [];
    $scope.getLocation(order_id)
  }

  $scope.getOrders = function() {
    showLoadingSpinner("Loading..")
    $http({
      url : "/ajax/account/orders?response_type=JSON",
      method: "GET"
    })
    .then(function(res){
      $scope.orders = res.data;
      overlay.hide();
    })
  }

  $scope.getLocation = function(order_id) {
    $http({
      url : "/ajax/account/orders/"+ order_id +"/location?response_type=JSON",
      method: "GET"
    })
    .then(function(res){
      $("#live_location_modal").modal('show');

      overlay.hide();

      var d = res.data;

      if(d['location']) {
        var customer_location = d['location']['customer_location'];
        var employee_location = d['location']['employee_location'];
        var user = d['location']['user'];
        var assigned_to = d['location']['assigned_to'];

        if(customer_location.latitude) {
          $scope.map_center = [customer_location.latitude, customer_location.longitude]
        }

        if(employee_location.latitude) {
          $scope.employee_location = [employee_location.latitude, employee_location.longitude];
        }

        // check if assigned_to has non-team leader
        if(assigned_to && assigned_to.length > 0) {
          if(assigned_to.length == 1) {
            $scope.technician = assigned_to[0];
          }
          else if(assigned_to.length > 1) {
            // group user by role
            var grouped_user = {
              "FO" : [],
              "TL" : []
            }
            grouped_user = _.groupBy(assigned_to, function(a){
              if(a.designation && (a.designation.toLowerCase().indexOf("team lead") > -1) ||  (a.designation.toLowerCase().indexOf("team leader") > -1) || (a.designation.toLowerCase().indexOf("tl") > -1) ) {
                return "TL"
              }
              else {
                return "FO";
              }
            });

            if(!grouped_user['TL']) {
              grouped_user['TL'] = [];
            }

            if(!grouped_user['FO']) {
              grouped_user['FO'] = [];
            }

            // If FO is available, but not TL
            if((grouped_user['FO'].length > 0) && (grouped_user['TL'].length == 0)) {
              $scope.technician = grouped_user['FO'][0];
              // If technician location is available, add that
              if($scope.technician.location) {
                $scope.employee_location = [ $scope.technician['location']['latitude'], $scope.technician['location']['longitude'] ]
              }
            }
            // If TL is available, but not FO
            else if( (grouped_user['TL'].length > 0) && (grouped_user['FO'].length == 0)) {
              $scope.technician = grouped_user['TL'][0];
              // If FO location is available, add that
              if($scope.technician.location) {
                $scope.employee_location = [ $scope.technician['location']['latitude'], $scope.technician['location']['longitude'] ]
              }
            }
            // If TL & FO are both available
            else if( (grouped_user['TL'].length > 0) && (grouped_user['FO'].length > 0)) {

              // Location is picked from TL if it is available with TL
              var team_leader = grouped_user['TL'][0];
              if(team_leader && team_leader.location && team_leader.location['latitude']) {
                // Second priority of technician is given to FO
                $scope.technician = grouped_user['TL'][0];
                $scope.employee_location = [ team_leader['location']['latitude'], team_leader['location']['longitude'] ]
              }
              // else if it is present in FO, show that
              else if($scope.technician.location) {
                $scope.technician = grouped_user['FO'][0];
                $scope.employee_location = [ $scope.technician['location']['latitude'], $scope.technician['location']['longitude'] ]
              }
            }

          }
        }

        // if(user) {
        //   $scope.technician = user;
        // }


      }

    })
  }


})

app.controller('ProfileController', function($scope, $http, $timeout){
  $scope.profile = {
    first_name : user.first_name,
    last_name  : user.last_name,
    phone_no   : user.local['phone_no']
  }
  $scope.password = {};

  $scope.updateProfile = function() {
    showLoadingSpinner("Updating Profile")
    $http({
      url : "/ajax/account/profile?response_type=JSON",
      method: "PUT",
      data  : {
        profile : $scope.profile
      }
    })
    .then(function(res){
      showAddedToCart("Profile Updated");
    });
  }

  $scope.updatePassword = function() {

    showLoadingSpinner("Updating Password")
    $http({
      url : "/ajax/account/password?response_type=JSON",
      method: "PUT",
      data  : {
        password : $scope.password
      }
    })
    .then(function(res){
      showAddedToCart("Password Updated");
      $scope.password = {};
    }, function(res){
      overlay.hide();
      swal("Error", res.data['message'], "error");
    });
  }

})

app.controller('BlogDetailsController', function($scope){
  $scope.formatDate = function(d) {
    return moment(d).format('DD MMMM YYYY')
  }

  $scope.blog_post = window.blog_post;

})

app.controller('BlogController', function($scope, $http, $timeout){

  $scope.posts = [];

  $scope.page = 1;
  $scope.limit = 50;

  $scope.formatDate = function(d) {
    return moment(d).format('DD MMMM YYYY')
  }

  $scope.getSummary = function(s) {
    if(s && s.length > 160) {
      return s.substring(0,160) + "...";
    }
    return s;
  }

  $scope.loadPosts = function() {
    $http({
      url : '/ajax/blog',
      params : {
        response_type: "JSON",
        page : $scope.page,
        limit : $scope.limit
      },
      method: "GET"
    }).then(function(res){
      var d = res.data['blog_posts'];
      $scope.posts = _.union($scope.posts, d['docs']);
      $scope.total_pages = d['total'];
    })
  }

  $scope.loadPosts();

  var c = window.localStorage.getItem('categories');
  if(c) {
    $scope.categories = JSON.parse(c);
  }

})
