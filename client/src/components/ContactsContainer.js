import React, { Component } from 'react'
import axios from 'axios'

class ContactForm extends Component {
  constructor(props) {
    super(props)
    this.state = {
      firstName: this.props.contact.firstName,
      lastName: this.props.contact.lastName,
      phone: this.props.contact.phone,
      email: this.props.contact.email
    }
  }

  handleInput = (e) => {
    this.props.resetNotification()
    this.setState({[e.target.name]: e.target.value})
  }

  handleBlur = () => {
    const contact = {firstName: this.state.firstName, lastName: this.state.lastName, phone: this.state.phone, email: this.state.email }
    axios.put(
      `http://localhost:3001/api/v1/contacts/${this.props.contact.id}`,
      {contact: contact}
      )
    .then(response => {
      console.log(response)
      this.props.updateContact(response.data)
    })
    .catch(error => console.log(error))
  }

  render() {
    return (
      <div className="tile">
        <form onBlur={this.handleBlur} >
          <input
            className='input'
            type="text"
            name="firstName"
            placeholder='First Name'
            value={this.state.firstName}
            onChange={this.handleInput}
            ref={this.props.firstNameRef}
          />
          <input
            className='input'
            type="text"
            name="lastName"
            placeholder='Last Name'
            value={this.state.lastName}
            onChange={this.handleInput}
            ref={this.props.lastNameRef}
          />
          <input
            className='input'
            type="text"
            name="phone"
            placeholder='Phone'
            value={this.state.phone}
            onChange={this.handleInput}
            ref={this.props.phoneRef}
          />
          <input
            className='input'
            type="text"
            name="email"
            placeholder='Email'
            value={this.state.email}
            onChange={this.handleInput}
            ref={this.props.emailRef}
          />
        </form>
      </div>
    );
  }
}

export default ContactForm
