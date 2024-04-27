package main

// import required packages, the goquery package is not part of the standard library
import (
	"fmt"
	"github.com/PuerkitoBio/goquery"
	"net/http"
)

// fetch function to fetch the URL and extract the title
func fetch(url string, done chan<- bool) {
	resp, err := http.Get(url)
	if err != nil {
		fmt.Println("Error fetching URL:", url)
		done <- true
		return
	}
	defer resp.Body.Close()

	// create a goquery document from the HTTP response
	document, err := goquery.NewDocumentFromReader(resp.Body) // goquery is a package to parse HTML documents
	if err != nil {
		fmt.Println("Error loading HTTP response body:", err)
		done <- true
		return
	}

	// extract the title of the page
	title := document.Find("title").Text()
	fmt.Printf("Title of %s: %s\n", url, title)

	// extract meta tags from all URLs, get the name and content attributes
	document.Find("meta").Each(func(index int, element *goquery.Selection) {
		if name, exists := element.Attr("name"); exists {
			content, _ := element.Attr("content")
			fmt.Printf("Meta [%s]: %s\n", name, content)
		}
	})

	// extract quotes and authors from quotes.toscrape.com
	if url == "http://quotes.toscrape.com" {
		document.Find(".quote").Each(func(index int, item *goquery.Selection) {
			quote := item.Find(".text").Text()
			author := item.Find(".author").Text()
			fmt.Printf("Quote: %s - %s\n", quote, author) // Print the quotes and authors
		})
	}

	done <- true // signal that the goroutine is done
}

func main() {
	websites := []string{"https://christmasjoy.dev", "https://en.wikipedia.org/wiki/Main_Page", "http://quotes.toscrape.com"}
	done := make(chan bool) // create a channel to signal when goroutines are done, channels keep goroutines in sync

	for _, url := range websites {
		go fetch(url, done) // goroutine! fetch each URL concurrently
	}

	for range websites {
		<-done // wait for all goroutines to finish, check the done channel
	}

	fmt.Println("Finished fetching all URLs.")
}
