import React from 'react';
import ReactDOM from 'react-dom';
import {
  DragDropContext,
  Droppable,
  Draggable,
} from 'react-beautiful-dnd';

const Layer = props => {
  const {
    id,
    title,
    stories,
  } = props;

  return (
    <Droppable droppableId={id}>
      {(provided, snapshot) => (
        <div ref={provided.innerRef} class="col-sm-4 col-md-3">
          <div class="card">
            <div class="card-body">
              <h4 class="card-title text-truncate py-2">{title}</h4>
              { stories.lenght === 0 ? (
                <h5 class="text-secondary">Empty</h5>
              ) : (
                <div>
                  { stories.map((story, index) => (
                    <Draggable
                      key={story.id}
                      draggableId={story.id}
                      index={index}>
                      {(provided, snapshot) => (
                        <div
                          ref={provided.innerRef}
                          {...provided.draggableProps}
                          {...provided.dragHandleProps}
                          style={getItemStyle(
                            snapshot.isDragging,
                            provided.draggableProps.style
                          )}
                          class="card p-2 bg-faded mb-2"
                        >
                          <h5 class="card-title">{ story.title }</h5>
                          <p>{ story.story }</p>
                        </div>
                      )}
                    </Draggable>
                    )
                  )}
                </div>
              )
              }
            </div>
          </div>
        </div>
      )}
    </Droppable>
  );
}

const getItemStyle = (isDragging, draggableStyle) => ({
    // some basic styles to make the items look a bit nicer
    userSelect: 'none',
    padding: grid * 2,
    margin: `0 0 ${grid}px 0`,

    // change background colour if dragging
    background: isDragging ? 'lightgreen' : 'grey',

    // styles we need to apply on draggables
    ...draggableStyle
});

// a little function to help us with reordering the result
const reorder = (list, startIndex, endIndex) => {
    const result = Array.from(list);
    const [removed] = result.splice(startIndex, 1);
    result.splice(endIndex, 0, removed);

    return result;
};

/**
 * Moves an item from one list to another list.
 */
const move = (source, destination, droppableSource, droppableDestination) => {
    const sourceClone = Array.from(source);
    const destClone = Array.from(destination);

    let [removed] = sourceClone.splice(droppableSource.index, 1);

    // update layer
    removed.layer = droppableDestination.droppableId;

    destClone.splice(droppableDestination.index, 0, removed);

    const result = {};
    result[droppableSource.droppableId] = sourceClone;
    result[droppableDestination.droppableId] = destClone;

    return result;
};

const grid = 8;

class Kanban extends React.Component {
  constructor(props) {
    super(props);

    const stories = JSON.parse(props.artifacts);
    const ids = [];

    // identify all layers
    stories.map(s => {
      if (!ids.includes(s.layer)) {
        ids.push(s.layer);
      }
    });

    this.state = {
      stories,
      ids,
    };
  }

  getList = id => this.state.stories.filter(s => s.layer === id);

  onDragEnd = result => {
    const { source, destination } = result;

    // dropped outside the list
    if (!destination) {
        return;
    }

    if (source.droppableId === destination.droppableId) {
        const items = reorder(
            this.getList(source.droppableId),
            source.index,
            destination.index
        );

        this.setState({stories: items});
    } else {
        const result = move(
            this.getList(source.droppableId),
            this.getList(destination.droppableId),
            source,
            destination
        );

        const stories = [].concat.apply([], Object.values(result));

        this.setState({
          stories,
        });
    }
  };

  render() {
    const { project } = this.props;
    const { stories, ids } = this.state;

    return (
      <DragDropContext onDragEnd={this.onDragEnd}>
        <div class="container-fluid pt-3">
          <h3>{project.name} <small>Kanban</small></h3>
          <div class="row flex-row flex-sm-nowrap py-5">
            {
              ids.map(id =>
                <Layer
                  id={id}
                  title="Title"
                  stories={stories.filter(s => s.layer === id)}
                />
              )
            }
          </div>
        </div>
      </DragDropContext>
    )
  }
}

export default Kanban;
