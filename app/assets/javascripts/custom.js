document.addEventListener("DOMContentLoaded", () => {
   const fileInput = document.querySelector("#post_images");
   const previewContainer = document.querySelector("#image-preview");
   let selectedFiles = []; // Stores previously selected files
   console.log("JavaScript is working!");
 
   if (fileInput) {
     fileInput.addEventListener("change", (event) => {
       const newFiles = Array.from(event.target.files);
       console.log("Files selected:", newFiles);

       // Merge new files with existing ones
       selectedFiles = selectedFiles.concat(newFiles);
 
       // Create a new DataTransfer object to store files
       const dataTransfer = new DataTransfer();
       selectedFiles.forEach((file) => dataTransfer.items.add(file));
 
       // Update file input with all selected files
       fileInput.files = dataTransfer.files;
 
       // Clear preview and show updated selection
       previewContainer.innerHTML = "";
       selectedFiles.forEach((file) => {
         const reader = new FileReader();
         reader.onload = (e) => {
           const img = document.createElement("img");
           img.src = e.target.result;
           img.style.maxWidth = "100px";
           img.style.margin = "5px";
           previewContainer.appendChild(img);
         };
         reader.readAsDataURL(file);
       });
     });
   }
 });
