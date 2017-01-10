/* global $ */

// Document ready
$(document).on('turbolinks:load', function() {
  // Set Stripe public key
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content'));
  // When user clicks submit button, prevent from submitting form
  
  // Collect credit card fields
  
  // Send card fields to Stripe
  
  // Stripe return card token
  
  // Inject card token as hidden field
  
  // Submit form
})
