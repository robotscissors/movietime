# Movie Time
This is a full-stack application that leverages an API from a [movie database](https://developers.themoviedb.org/3). The API features a community built data-source that began in 2008. To date, the MovieDB has seen over 150,000 users of this metadata source. On average over 1,000 images are added every single day.

![Movie Time Screenshot](https://user-images.githubusercontent.com/24664863/42741467-63c2f30c-8867-11e8-997f-95ec017d77b0.png)

## The Task
Create a TV show discovery application. Using any framework or language, create an application to leverage the open-source metadata of the API with the following functional requirements:

### Functional Requirements
1. When the app first loads, there should be a list of popular TV shows (as determined by the API) and a search bar.
2. Upon using the search bar, the user should see a list of shows that match the seach criteria.
3. After clicking on a TV show (from the search or main page) the user should be taken to a page with more information about that particular TV show.

### Technical Requirements
- Create a full-stack application with a backend that communicates with the [movie API](https://developers.themoviedb.org/3).
- The front-end should be intuitive to use.
- Make sure your code includes a full test suite.
- Deploy your site to a webhost.


### Technology Choice
Before we get started, I chose Rails as framework for the ruby language.

#### Why Ruby on Rails?
Ruby on Rails is ideal for this type of quick solution application. This choice is quite common for applications that fit into the prototyping and fast delievery category. Many of the details in including and requiring dependanices are solved for you. It definately is a little "heavier" than is needed for this purpose but it definately did the job.

In hindsight, a better option might have been Sinatra. My experience has been that while Sinatra is light, there are many things we take for granted in Rails that tend to cause complications when you aren't paying close attention.

## Meeting the Functional Requirements
### Application, when first loaded, lists popular TV shows
<p align="center">
<img src="https://user-images.githubusercontent.com/24664863/42741712-8dbfa1b2-8869-11e8-95e4-7cf246273679.png" alt="Desktop Image"  height="450">&nbsp;<img src="https://user-images.githubusercontent.com/24664863/42741754-de73cbba-8869-11e8-9d6f-0f628f02dd50.png" alt="Mobile Image"  height="450">
</p>

#### How I achieved that?


### Upon searching for a TV show in the search bar, the user should see a list of shows whose title matches.
<p align="center">
<img src="https://user-images.githubusercontent.com/24664863/42742055-96eb33b6-886c-11e8-806b-076026ed50bc.png" height="450">
</p>

#### How does that work?

### After clicking on a TV show, the user is taken to a page with more information about that show.
<p align="center">
  <img src="https://user-images.githubusercontent.com/24664863/42742149-80ffbf94-886d-11e8-990f-032522531640.png" height="450">
</p>

#### How did I make that happen?
