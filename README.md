# MultiInOne
讓Core Data 資料庫可以執行在單一background thread讀寫。Core Data saving objects in background.<br>
原用來，用來解決將不同執行緒對Core Data資料庫進行讀寫時，會因多緒造成資料不同步問題，但若使用預設main thread則會大量影嚮ui的反應速度，因此實作此機制可在背景進行網路操作，且可多緒轉單緒。
<br>
<br>
使用方式如下:
* 非同步執行<br>
[[MultiInOneExecutor sharedinstance] submitAsync:^{<br>
    //TODO 此處可執行網路操作，且不會佔用main thread<br>
  }];<br>

* 同步執行<br>
 [[MultiInOneExecutor sharedinstance] submitSync:^{<br>
 //TODO 此處可執行網路操作，且不會佔用main thread<br>
        }];<br>
