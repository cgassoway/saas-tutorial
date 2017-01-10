/* global $, Stripe */

// Document ready
$(document).on('turbolinks:load', function() {
  var theForm=$('#pro_form')
  var submitBtn=$('#form-signup-btn')
  
  // Set Stripe public key
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content'));
  
  // When user clicks submit button, prevent from submitting form at that time
  submitBtn.click(function(event) {
    event.preventDefault();
    submitBtn.val("Processing").prop('disabled', true);
    
    
    // Collect credit card fields
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
    // Send card fields to Stripe
    
    // Use Stripe library to check for card errors
    var error = false;
  
    //Validate card number
    if(!Stripe.card.validateCardNumber(ccNum)) {
      error = true;
      alert( "The credit card number appears to be invalid");
    }
      
    //Validate cvc number
    if(!Stripe.card.validateCVC(cvcNum)) {
      error = true;
      alert( "The CVC number appears to be invalid");
    }
    
    //Validate expiration date
    if(!Stripe.card.validateExpiry(expMonth, expYear)) {
      error = true;
      alert( "The expiration date appears to be invalid");
    }
    
    if (error) {
      //  Don't send to Stripe, but reenable the submit button
      submitBtn.prop('disabled', false).val("Sign Up");
    } else {
      Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
      }, stripeResponseHandler);
    }
    return false;
  });
  
  
  
  // Stripe return card token
  function stripeResponseHandler(status, response) {
    // Get the token from the response
    var token = response.id;
    
    // Inject card token in hidden field
    
    theForm.append( $('<input type="hidden"> name = "user[stripe_card_token]">').val(token) );
    
    theForm.get(0).submit();
  }
  
  // Inject card token as hidden field
  
  // Submit form
});