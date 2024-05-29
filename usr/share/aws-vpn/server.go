package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"os"
)

func main() {
	http.HandleFunc("/", SAMLServer)
	http.ListenAndServe("127.0.0.1:35001", nil)
	os.Exit(0)
}

func SAMLServer(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "POST":
		if err := r.ParseForm(); err != nil {
			fmt.Fprintf(w, "ParseForm() err: %v", err)
			return
		}
		SAMLResponse := r.FormValue("SAMLResponse")
		if len(SAMLResponse) == 0 {
			log.Printf("SAMLResponse field is empty or not exists")
			return
		}
		ioutil.WriteFile("/tmp/saml-response.txt", []byte(url.QueryEscape(SAMLResponse)), 0600)
		w.Header().Add("Content-Type", "text/html")
		fmt.Fprintf(w, "Got SAMLResponse field, it is now safe to close this window"+
			"<script>window.close()</script>")
		return
	default:
		fmt.Fprintf(w, "Error: POST method expected, %s recieved", r.Method)
	}
}
