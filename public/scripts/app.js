
$(document).ready(function() {
  console.log("SYSTEM: Document Ready")

  // Rearrange List Items
  $("tbody").sortable({axis: "y", connectWith: "tbody"});
  // - Was having undesired behavior without self-connectWith.
  // - This abandons the paired spacer row.
});
