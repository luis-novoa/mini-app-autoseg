$(document).ready(function () {
  $('.tasks').find('ul').data({
    sublistCounter: 1,
    sublistUniqueID: 1,
    parentID: 'list',
    parentName: 'list'
  });

  $('.delete-task').click(removeParentTask);

  $('.add-task').click(addTask);

  $('.add-subtask').click(addSubtask);
});

function createElements(object) {
  const counter = object.data('sublistUniqueID');
  object.data('sublistUniqueID', object.data('sublistUniqueID') + 1);
  const ancestorsID = object.data('parentID');
  const ancestorsName = object.data('parentName');
  const id = `${ancestorsID}_sublists_attributes_${counter}_description`;
  const name = `${ancestorsName}[sublists_attributes][${counter}][description]`
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

function addTask(e) {
  e.preventDefault();
  const { input, label, deleteButton, subtaskButton } = createElements($(this).parent());
  const newTask = $("<li class='task'></li>").append(label, input, subtaskButton, deleteButton);
  $(this).before(newTask);
  updateCounter(1, $(this).parent());
}

function addSubtask(e) {
  e.preventDefault();
  const input = $(this).prev();
  $(this).parent().append(createSubtaskForm(input));
}

function createSubtaskForm(siblingInput) {
  const newUL = $('<ul></ul>').data({
    sublistCounter: 0,
    sublistUniqueID: 0,
    parentID: siblingInput.attr('id').replace('_description', ''),
    parentName: siblingInput.attr('name').replace('[description]', '')
  });
  const { input, label, deleteButton, subtaskButton } = createElements(newUL);
  const newTask = $(`<li class='task' id='${newUL.data('parentID')}'></li>`);
  newTask.append(label, input, subtaskButton, deleteButton);
  const addTaskButton = $("<button class='add-task'>Add Another Subtask</button>").click(addTask);
  newUL.append(newTask, addTaskButton);
  return newUL;
}

function removeParentTask(e) {
  e.preventDefault();
  const parent = $(this).parent();
  updateCounter(-1, parent.parent());
  parent.remove();
}

function updateCounter(amount, object) {
  object.data('sublistCounter', object.data('sublistCounter') + amount);
}
