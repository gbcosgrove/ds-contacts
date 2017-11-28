import React, { Component } from 'react'
import './App.css'
import ContactsContainer from './components/ContactsContainer'

class App extends Component {
  render() {
    return (
      <div className="App">
        <div className="App-header">
          <h1>Contact Board</h1>
        </div>
        <ContactsContainer />
      </div>
    );
  }
}

export default App

