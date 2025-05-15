# elGrocerAssignment


Note: Please use any of these Email and Password for login
        email: "ibrar@elgrocer.com", password: "ibrar1234"
        email: "anas@elgrocer.com", password: "ibrar1234"
        email: "ali@elgrocer.com", password: "ibrar1234"

Archetecture:
    In both the Login and Home modules, I have implemented the MVVM (Model-View-ViewModel) architecture.
    To make the system more testable and modular, I’ve used dependency injection for passing services and view models.


AppStart:
    When the app starts, it checks if the user is already logged in (by checking a saved token).
       If yes, it goes directly to the home screen.
       If no, it shows the login screen.
       This logic is handled in a class called AppCoordinator.
 
   
LoginViewController:
    The LoginViewController creates all the UI elements in code: 
        Email input field
        Password input field
        Login button
        Loading spinner
        These elements are arranged vertically using a stack view.
        There’s also a helper function to style the text fields with padding, rounded corners, and shadows. I use extension class for this.

    
LoginViewModel:
    When the user taps the login button, A spinner shows to indicate loading.
    The app calls the login function in the LoginViewModel.
       Inside the ViewModel:
            First, it checks if the email format is correct.
            Then, it checks if the password is at least 6 characters.
            If both are okay, it waits 2 seconds to simulate a network call.
            Then, it checks if the entered email and password match any of the predefined users in LoginModel.
            If the login is successful:
                A mock token is saved using KeychainService.
                The user is taken to the home screen.
            If login fails:
                An error alert is shown.


LoginModel:
    It’s a simple struct that contains a list of users and a function to check if the provided email and password are correct.
   
    
KeychainService:
    Saves the login token.
    Checks if the token exists.
    Removes the token when the user logs out, If needed.
    I use UserDefaults here to simulate secure storage.
    

AppCoordinator:
    Determining which screen to show first (Login or Home)
    Managing navigation between Login and Home screens
    Injecting dependencies


HomeViewController:
    This screen contain 3 main things: 
    Banners, Categories, Products
    I uses UICollectionView with modern compositional layout and diffable data source to make the UI smooth and easy to update.
    
    I split the collection view into 3 sections:
        Banners: full width with auto-scroll every 3 seconds
        Categories: Display 4 categories per row and 2 rows with horizontally scrollable layout.
        Products: Display a list of product, at least 20 products with two products in a row and vertically scrollable.
        
    Each section is created using a special layout builder:
        createBannerSection()
        createCategoriesSection()
        createProductsSection()
        
    Data loaded:
        The view model (HomeViewModel) fetches data (banners, categories, products).
        While loading, a spinner is shown.
        Once data is ready, it is added to the collection view using a UICollectionViewDiffableDataSource for smooth UI updates.
        All UI is built using code (no Storyboard used).
        
    Banner autoscroll work:
        A timer is started when the screen loads. Every 3 seconds.
        It moves the banner to the next item.
        When it reaches the last banner, it starts again from the first.
        This is done using Timer and scrollToItem.
        

HomeItemCell:
    containerView: A rounded box with shadow.
    iconImageView: An image shown at the top (e.g., product image or icon).
    titleLabel: A label shown below the image (e.g., product name or category title).
        
    DisplayData:
            The configure(with item: HomeItem) function sets
            titleLabel.text = item’s title
            iconImageView.image = item’s system image name (from SF Symbols).
            
            
HomeViewModel:
    banners: [HomeItem] – List of banner items (e.g., promotional images).
    categories: [HomeItem] – List of category items (e.g., Electronics, Clothing).
    products: [HomeItem] – List of product items (e.g., a phone, laptop).
        
    Data loaded:
            It calls a method HomeItem.fetchAllData(...).
            This fetches data for banners, categories, and products HomeItem.
            Once the data is fetched, it assigns it to the view model's arrays.
            After storing the data, it runs the completion() to let the view controller know that the data is ready to use.
            
            
HomeItem:
    A simple data model used for UI.
    Equipped with static methods for generating mock data. getBanners(), getCategories(), getProducts()
    Supports async simulation to API behavior.
    Works great with MVVM and CollectionView Diffable Data Sources.
        


