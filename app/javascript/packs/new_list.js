$(document).ready(function () {
  $('.tasks').find('ul').data({
    taskCounter: 1,
    taskUniqueID: 1,
    sublistCounter: 0,
    sublistUniqueID: 0,
    parentID: 'list',
    parentName: 'list'
  });

  $('.delete-task').click(removeParentTask);

  $('.add-task').click(function (e) {
    e.preventDefault();
    const { input, label, deleteButton, subtaskButton } = createElements('task', $(this).parent());
    const newTask = $("<li class='task'></li>").append(label, input, subtaskButton, deleteButton);
    $(this).before(newTask);
    updateCounter('task', 1, $(this).parent());
  });

  $('.add-subtask').click(addSubtask);
});

function createElements(type, object) {
  const attr = type + 's_attributes';
  const counter = object.data(`${type}UniqueID`);
  object.data(`${type}UniqueID`, object.data(`${type}UniqueID`) + 1);
  const ancestorsID = object.data('parentID');
  const ancestorsName = object.data('parentName');
  const id = `${ancestorsID}_${attr}_${counter}_description`;
  const name = `${ancestorsName}[${attr}][${counter}][description]`
  const deleteButton = $("<button class='delete-task'>Delete this Task</button>").click(removeParentTask);
  const subtaskButton = $("<button class='add-subtask'>Add Subtask</button>").click(addSubtask);
  const label = `<label for='${id}'>Description</label>`;
  const input = $('<input></input>').attr({
    'type': 'text',
    'name': name,
    'id': id
  });
  return {
    label: label,
    input: input,
    deleteButton: deleteButton,
    subtaskButton: subtaskButton
  };
}

function addSubtask(e) {
  e.preventDefault();
  turnIntoSublist($(this).parent());
}

function removeParentTask(e) {
  e.preventDefault();
  let parent = $(this).parent();
  updateCounter(parent.attr('class'), -1, parent.parent());
  parent.remove();
}

function turnIntoSublist(task) {
  const ul = task.parent();
  const previous = task.prev();
  let { input, label, deleteButton } = createElements('sublist', ul);
  const newSublist = $("<li class='sublist'></li>").append(label, input, deleteButton);
  task.remove();
  updateCounter('task', -1, ul);
  updateCounter('sublist', 1, ul);
  console.log()
  if (previous.html() == undefined) {
    ul.prepend(newSublist);
  } else {
    previous.after(newSublist);
  }
  // let { input, label, deleteButton, subtaskButton } = createElements('task', newSublist);
  // const newSubtask = $("<li class='task'></li>").append(label, input, subtaskButton, deleteButton);
  // newSublist.prepend(newSubtask);
}

function updateCounter(type, amount, object) {
  object.data(`${type}Counter`, object.data(`${type}Counter`) + amount);
}
