$(document).ready(function () {
  $('.tasks').find('ul').data({
    taskCounter: 1,
    sublistCounter: 0,
    parentID: 'list',
    parentName: 'list'
  });

  $('.delete-task').click(removeParentTask);

  $('.add-task').click(function (e) {
    e.preventDefault();
    // const newTaskLabel = "<label for='list_tasks_attributes_0_description'>Description</label>";
    // const newTaskInput = $('<input></input>').attr({
    //   'type': 'text',
    //   'name': 'list[tasks_attributes][0][description]',
    //   'id': 'list_tasks_attributes_0_description'
    // });
    // const deleteButton = $("<button class='delete-task'>Delete this Task</button>").click(removeParentTask);
    const { input, label, deleteButton } = createElements('task', $(this).parent());
    const newTask = $("<li class='task'></li>").append(label, input, deleteButton);
    $(this).before(newTask);
    updateCounter('task', 1, $(this).parent());
  });
});

function createElements(type, object) {
  const attr = type + 's_attributes';
  const counter = object.data(`${type}Counter`);
  const ancestorsID = object.data('parentID');
  const ancestorsName = object.data('parentName');
  const id = `${ancestorsID}_${attr}_${counter}_description`;
  const name = `${ancestorsName}[${attr}][${counter}][description]`
  const deleteButton = $("<button class='delete-task'>Delete this Task</button>").click(removeParentTask);
  const label = `<label for='${id}'>Description</label>`;
  const input = $('<input></input>').attr({
    'type': 'text',
    'name': name,
    'id': id
  });
  return {
    label: label,
    input: input,
    deleteButton: deleteButton
  };
}

function removeParentTask(e) {
  e.preventDefault();
  updateCounter('task', -1, $(this).parent().parent());
  $(this).parent().remove();
}

function updateCounter(type, amount, object) {
  object.data(`${type}Counter`, object.data(`${type}Counter`) + amount);
}
