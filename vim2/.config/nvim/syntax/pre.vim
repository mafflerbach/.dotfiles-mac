if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match   reference           "Triplink"
syn match   reference           "Concure"
syn match   reference           "SAP"
syn match   reference           "Sixt"



syn match   topic           "Get.http"
syn match   topic           "Put.http"
syn match   topic           "Delete.http"
