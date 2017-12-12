import * as actionTypes from './../actions/actionTypes';


const initialState = "";

export const routesReducer = (state = initialState, action: any) => {
  switch (action.type) {
    case actionTypes.NAVIGATE:
      return action.route;
    default:
      return state;
  }
};
