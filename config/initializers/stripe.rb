Rails.configuration.stripe = {
    #:publishable_key => ENV['PUBLISHABLE_KEY'],
    #:secret_key      => ENV['SECRET_KEY']
    :publishable_key => ENV[pk_test_JfkJNk8SSeqeBrfmHhKBh4K6],
    :secret_key      => ENV[sk_test_1IGSWRw5f2lM59WGIQqGgqcX]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
