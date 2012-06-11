# MicrosoftTranslator

Ruby wrapper for Microsoft Translate HTTP API.

Still a work-in-progress. Currently only supports translating one string
of text at a time.

## Installation

Before translating things from your ruby application you first need to
sign up for the Microsoft Translator API in the Windows Azure
Datamarket.  

https://datamarket.azure.com/dataset/1899a118-d202-492c-aa16-ba21c33c06cb

Don't worry, they have a free tier! (up to 2 million translated characters/month) Once you sign up for the Translator
API you will also need to register your application with the Azure
Datamarket.  

https://datamarket.azure.com/developer/applications/

Also, you shouldn't stress about what to put for the _*Redirect URI*_. For the purposes of
this gem you won't be using it so your project's homepage will work just
fine.  You'll use the _*Client ID*_ and _*Client secret*_ to authenticate
your requests to the API.  Once this is done you'll install it like you
would any other gem...

Add this line to your application's Gemfile:

    gem 'microsoft_translator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install microsoft_translator

## Usage

Create a MicrosoftTranslator::Client with your Client ID & secret.

```ruby
translator = MicrosoftTranslator::Client.new('your_client_id', 'your_client_secret')
```

To translate pass in the foreign text allong with the language codes for
the language you are going from/to and the content type. The content
type is either "text/plain" or "text/html"

```ruby
spanish = "hasta luego muchacha"
translator.translate(spanish,"es","en","text/html")
   # =>  "until then girl"
```

That's about it!  This is a list of the supported languages by the Microsoft 
Translate API http://www.microsofttranslator.com/help/?FORM=R5FD and
here are all the language codes as a helpful reference.
http://www.loc.gov/standards/iso639-2/php/code_list.php

## Contributing

There are still quiet a few other methods available in the API that need
to be covered.  http://msdn.microsoft.com/en-us/library/ff512419.aspx

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
