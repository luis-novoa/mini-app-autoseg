$(document).ready(function () {
  // const test = "<h1>I'm the god of Jquery :3</h1>"
  // $('.new-list-form').prepend(test);

  $('.delete-task').click(removeParent);

  $('.add-task').click(function (e) {
    e.preventDefault();
    if ($('li.task').last().html() == undefined) {
      const newTaskLabel = "<label for='list_tasks_attributes_0_description'>Description</label>";
      const newTaskInput = $('<input></input>').attr({
        'type': 'text',
        'name': 'list[tasks_attributes][0][description]',
        'id': 'list_tasks_attributes_0_description'
      });
      const deleteButton = $("<button class='delete-task'>Delete this Task</button>").click(removeParent);
      const newTask = $("<li class='task'></li>").append(newTaskLabel, newTaskInput, deleteButton);
      $(this).parent().prepend(newTask);
      return;
    }
  });
});

function removeParent(e) {
  e.preventDefault();
  $(this).parent().remove();
}