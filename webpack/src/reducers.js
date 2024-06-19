import { combineReducers } from 'redux';
import EmptyStateReducer from './Components/EmptyState/EmptyStateReducer';

const reducers = {
  foremanVcenterDemo: combineReducers({
    emptyState: EmptyStateReducer,
  }),
};

export default reducers;
