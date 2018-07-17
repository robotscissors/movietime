# Movie Time
This is a full-stack application that leverages an API from a [movie database](https://developers.themoviedb.org/3). The API features a community built data-source that began in 2008. To date, the MovieDB has seen over 150,000 users of this metadata source. On average over 1,000 images are added every single day.

![Movie Time Screenshot](https://user-images.githubusercontent.com/24664863/42741467-63c2f30c-8867-11e8-997f-95ec017d77b0.png)

## The Task
Create a TV show discovery application. Using any framework or language, create an application to leverage the open-source metadata of the API with the following functional requirements:

### Functional Requirements
1. When the app first loads, there should be a list of popular TV shows (as determined by the API) and a search bar.
2. Upon using the search bar, the user should see a list of shows that match the search criteria.
3. After clicking on a TV show (from the search or main page) the user should be taken to a page with more information about that particular TV show.

### Technical Requirements
- Create a full-stack application with a backend that communicates with the [movie API](https://developers.themoviedb.org/3).
- The front-end should be intuitive to use.
- Make sure your code includes a full test suite.
- Deploy your site to a webhost.


### Technology Choice
Before we get started, I chose Rails as framework for the ruby language.

#### Why Ruby on Rails?
Ruby on Rails is ideal for this type of quick solution application. This choice is quite common for applications that fit into the prototyping and fast delivery category. Many of the details in including and requiring dependencies  are solved for you. It definitely is a little "heavier" than is needed for this purpose but it definitely did the job.

In hindsight, a better option might have been Sinatra. My experience has been that while Sinatra is light, there are many things we take for granted in Rails that tend to cause complications when you aren't paying close attention.

## Meeting the Functional Requirements
### Application, when first loaded, lists popular TV shows
<p>
<img src="https://user-images.githubusercontent.com/24664863/42741712-8dbfa1b2-8869-11e8-95e4-7cf246273679.png" alt="Desktop Image"  height="450">&nbsp;<img src="https://user-images.githubusercontent.com/24664863/42741754-de73cbba-8869-11e8-9d6f-0f628f02dd50.png" alt="Mobile Image"  height="450">
</p>

#### How I achieved that?
The first step was getting the API up and running. I knew that the entire project hinged on whether or not I could figure out how to get data from this outside source. Since the application itself had no stored data (no internal DB), the model portion of MVC was in charge of communicating with the outside data source.

The [HTTParty gem](https://github.com/jnunemaker/httparty) is amazing. Since most of my previous projects had never relied on consuming a REST API, I knew my first step getting a response. This GEM returns JSON and then is beautifully accessible via a hash. By including the gem in my gem file and then using the ````include HTTParty```` in my class, I have access to HTTParty's methods. I was surprised at how easy it was.

__My first Class (The Tv Class)__
````
class Tv
  include HTTParty

  base_uri 'https://api.themoviedb.org/3'
  default_params api_key: ENV['API_KEY']
  format :json

  def self.popular_tv
    get("/discover/tv", query: {sort_by: "popularity.desc"})
  end

  def self.all(page, sort)
    get("/discover/tv", query: {sort_by: sort, page: page})
  end

  def self.one(tv_id)
    get("/tv/#{tv_id}",query: {})
  end

  def self.reviews(tv_id)
    get("/tv/#{tv_id}/reviews",query: {})
  end
end
````

The controller where all the coordination takes place is where I manage to take only the top 12 results for the homepage, why 12? Well it looks good!

````
class WelcomeController < ApplicationController
  def index
    @popular_tv = Tv.popular_tv['results'].take(12) #get top 12 for home page
    @popular_movie = Movie.popular['results'].take(6)
    @popular_people = Person.popular['results'].take(6)
  end
end
````

### Upon searching for a TV show in the search bar, the user should see a list of shows whose title matches.
<p>
<img src="https://user-images.githubusercontent.com/24664863/42742055-96eb33b6-886c-11e8-806b-076026ed50bc.png" height="450">
</p>

I opted to use the search/multi option which allowed me to search the entire database of entries. Each media type has their own endpoint in the API, but I felt if I truly wanted to search the entire database, the search/multi would be the correct option.

<img width="798" alt="image of the search/multi endpoint" src="https://user-images.githubusercontent.com/24664863/42782114-d20d363e-88fc-11e8-84e3-aba36642cd9d.png">

#### How does that work?
After someone submits from the search bar, a POST request is made to the search controller with the index action (search#index)

````
class SearchController < ApplicationController
  def index
    @search_query = params[:query]
    @page = params[:page].to_i
    @page = 1 if @page === 0
    @search = Search.for(@search_query,@page)
    @total_pages = @search['total_pages']
    @total_results = @search['total_results']
    @search_results = @search['results']
    @errors = @search['errors']
  end
end
````

We take the search query-term that was submitted through the post and then use that as a parameter when calling the end point through search model.

````
class Search
  include HTTParty

  base_uri 'https://api.themoviedb.org/3'
  default_params api_key: ENV['API_KEY']
  format :json

  def self.for(term, page)
    get("/search/multi", query: {query: term, page: page})
  end
end
````

The result is a hash of the matching criteria for a movie, TV show or actor.


### After clicking on a TV show, the user is taken to a page with more information about that show.
<p>
  <img src="https://user-images.githubusercontent.com/24664863/42742149-80ffbf94-886d-11e8-990f-032522531640.png" height="450">
</p>

#### How did I make that happen?
Clicking on one of the images process a get request to this route ````tv#show```` and tagging on the ````tv_id```` parameter that is unique to every show. 

````
  def show
    @tv_id = params[:tv_id].to_i

    if @tv_id
      @tv_program = Tv.one(@tv_id) #returns the details for one show\
      @reviews = Tv.reviews(@tv_id)['results'].take(3) #take only 3
    else
      @errors = "Hmm, I don't know what happened here. Try again."
    end
  end
````

Upon checking the parameter's presence, it then fetches the program details by calling the Tv.one class method (written below). In addition, it also calls the ````Tv.reviews```` class method to obtain reviews (I ask for only three since pagination isn't being addressed in this MVP.

````
  def self.one(tv_id)
    get("/tv/#{tv_id}",query: {})
  end
````

## The Design, UX and UI
I knew just from the project goals and looking at the data that I wanted to make this a visual app. The fewer words on the page the better. You'll notice in all the #index actions the view consists of representations of the movie posters, TV posters or actor headshots.

### The color schemes
I wanted to have a color scheme that went with a variety of colors so I looked for color combinations that had a neutral background. So I choose the following as my theme. I kept my color choices to these four colors. By choosing colors early on in the layout process it gave me confidence in designing the layout without worrying if colors were clashing.

<img width="136" alt="Colors for project" src="https://user-images.githubusercontent.com/24664863/42781211-58af7bf0-88fa-11e8-887b-fe2b56e6acfc.png">

### Using Sass instead of CSS
Sass. I love it. I think the main advantage in this project was being able to nest selectors easily within HTML Semantic Elements and other selectors.

Reasoning behind your technical choices. This may include trade-offs you might have made, anything you left out, and what you might do differently if you had more time to spend on the project

### Displaying the data
For a large part of the application we are displaying images for posters, TV covers and actor headshots. Arranging them using float was a little bit a of pain. Then, I was introduced to Flexbox. Flexbox is pretty cool, especially when it comes to organizing items. Now, it is a little unruly at times, probably because I am not an expert at it yet, but I can definitely see the advantages of its use.

### Mobile resposiveness
The application is mobile-responsive. That being said, if I had more time, I would work smarter on the navigation. I again used flexbox for the top nav instead of the go to choice of Bootstraps nav themes. Regardless, for this quick sprint, the nav is functional on mobile and responsive.


# Extra Credit

## Include Movies
As I mentioned above, using the ````search/multi```` endpoint, I had access to all media types. In my application, the main page features to top TV shows, the top Movies and the top Actors. In addition, the search controller performs search on all these media types as well. 

#### So was it a good choice to use search/multi?
Well yes and no. It is a very easy catch all. However, if plans include to exclusively search one media over another, or use autocomplete to show categorized lists of search results, the multi endpoint may not have been the best choice. If I had more time with a clear roadmap, I think I would have opted to creating other models with specific search methods for each media type.

## Attach Reviews to Each Show

<img width="829" alt="TV Reviews endpoint" src="https://user-images.githubusercontent.com/24664863/42786833-9cc3b330-890c-11e8-8cdc-d964d230d85f.png">

Although a complete review endpoint is available, I choose only to implement reviews for TV shows as indicated in the extra credit statement. To be clear, I am only returning the first page of reviews. But with more time, this could be expanded into multi page reviews with pagination.

<img width="700" alt="Image of Reviews and Season info" src="https://user-images.githubusercontent.com/24664863/42786999-5a96a73c-890d-11e8-9e6f-489599b26c6a.png">

### Also included Season information (if available)
Since accessing the endpoint was so intuitive I decided to show the Season information as well. It was an simple addition from the Details endpoint.

### When a user searches an actor or actress, display their biography first.
I also added actors to the list of searchable items. Once clicking on an actor's photo their biography overview will be displayed along with the actor's name and a few other details.

<img width="1427" alt="Actor Henry Cavill" src="https://user-images.githubusercontent.com/24664863/42787141-0da377a6-890e-11e8-9a77-dc4230e8cb6f.png">

### Adding actor names to photos
I noticed when actors were part of the search results, all that was displayed was their photo. It was hard to tell, not knowing the name of the actor, whether the search rendered the correct results. So through CSS I added the names of the actors as well.

### But what if an image is missing? 
No worries, I added the name to a default image, if the image is missing.

<img width="1477" alt="Image of search results" src="https://user-images.githubusercontent.com/24664863/42787292-b913b4de-890e-11e8-8845-cb785f186be7.png">

# Testing - RSPEC
This app needed to be tested. The overall test suite is 55 exclusive tests. 
<p>
<img width="1038" alt="Image of search rspec tests" src="https://user-images.githubusercontent.com/24664863/42790367-862c8cd8-891f-11e8-9680-0f3c996cac07.png">
</p>
RSPEC and I have a complicated relationship. I know TDD is very important and the principles involved are, in my opinion, unrefutable. Because I don't use RSPEC in my everyday life I find myself looking up comparisons or settling on what I CAN do as opposed to what I WANT to do. Regardless, I feel the testing is pretty substantial.

The most important test was the first one that allowed me to see whether or not I was getting a response in the Model. More specifically, testing the API:

````
require 'rails_helper'

RSpec.describe Tv, type: :model do

  describe "TV/discover/tv" do
    it "returns success" do
      api_call = Tv.popular_tv
      expect(api_call.respond_to?(:response)).to be_truthy
    end

    it "responds to calls to get popular TV programs" do
      @popular_tv = Tv.popular_tv
      expect(@popular_tv).not_to be_empty
    end

    it "responds to calls to get all popular TV programs" do
      @sort = "popularity.desc"
      @page = 1
      @all_tv = Tv.all(@sort, @page)
      expect(@all_tv).not_to be_empty
      expect(@all_tv['page']).to eq(1) #make sure it returns the first page
    end

    it "responds to call to get only one tv program and details" do
      @tv_id = 1396 #The first purge
      @tv = Tv.one(@tv_id)
      expect(@tv).not_to be_empty
      expect(@tv['original_name']).to include('Breaking Bad')
    end

    it "responds to reviews if they are available" do
      @tv_id = 1396 #The first purge
      @tv = Tv.reviews(@tv_id)
      expect(@tv).not_to be_empty #there are reviews for breaking bad
    end
  end
end
````

From there it was all about testing everything &mdash; Every model, controller and view.


# What if I Had More Time?

All-in-all the app meets the functional requirements. But there are still plenty of enhancements that can be completed:

1. Autocomplete with category separation - most people know they are searching for Movie, Actor of TV show so it would be nice to be able to differentiate those during search.
2. Improve the Mobile NAV bar. Although the app is respsonsive and looks O.K. on mobile, more can be done.
3. Add some transitions on roll over of the images just to spice things up a little.
4. Refactor the Sass files to improve readability.

# Other Important Information

- Ruby version: ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin16]
- Rails version: Rails 5.0.1
- Bundler version: 1.16.2
