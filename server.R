
library(shiny)
library(RCurl)
library(jsonlite)
library(utils)

function(input, output) {
	
	output$dt <- renderDataTable({
		v$data
	})
	
	v <- reactiveValues(data = NULL)
	
	observeEvent(input$do, {
		token <- input$Token
		URL <- paste0("https://graph.facebook.com/v2.5/search?limit=50&type=", input$Type, "&q=", URLencode(input$Query))
		URL <- paste0(URL,"&access_token=", token)
		print(URL)
		x<- getURL(URL)
		#https://graph.facebook.com/v2.5/search?type=adTargetingCategory&class=behaviors&q=RTBF
		x <- gsub("\n","", x)
		View(fromJSON(x)$data)
		v$data <- fromJSON(x)$data
	})
}