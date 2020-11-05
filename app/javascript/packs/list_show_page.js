$(document).ready(function () {
  const hideButton = $('<button>Hide Subtasks</button>').click(hideChildren);
  $('.task').find('ol').before(hideButton);
});

function hideChildren() {
  const showButton = $('<button>Show Subtasks</button>').click(showChildren);
  $(this).next().hide();
  $(this).after(showButton);
  $(this).remove();
}

function showChildren() {
  const hideButton = $('<button>Hide Subtasks</button>').click(hideChildren);
  $(this).next().show();
  $(this).after(hideButton);
  $(this).remove();
}
