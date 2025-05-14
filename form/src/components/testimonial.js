import React from 'react'

import PropTypes from 'prop-types'

import './testimonial.css'

const Testimonial = (props) => {
  return (
    <div className="thq-section-padding">
      <div className="testimonial-max-width thq-section-max-width">
        <div className="testimonial-container10">
          <h2 className="thq-heading-2">{props.heading1}</h2>
          <span className="testimonial-text11 thq-body-small">
            {props.content1}
          </span>
        </div>
        <div className="thq-grid-2">
          <div className="thq-animated-card-bg-2">
            <div className="thq-animated-card-bg-1">
              <div data-animated="true" className="thq-card testimonial-card1">
                <div className="testimonial-container12">
                  <img
                    alt={props.author1Alt}
                    src={props.author1Src}
                    className="testimonial-image1"
                  />
                  <div className="testimonial-container13">
                    <strong className="thq-body-large">
                      {props.author1Name}
                    </strong>
                    <span className="thq-body-small">
                      {props.author1Position}
                    </span>
                  </div>
                </div>
                <span className="testimonial-text14 thq-body-small">
                  {props.review1}
                </span>
              </div>
            </div>
          </div>
          <div className="thq-animated-card-bg-2">
            <div className="thq-animated-card-bg-1">
              <div data-animated="true" className="thq-card testimonial-card2">
                <div className="testimonial-container14">
                  <img
                    alt={props.author2Alt}
                    src={props.author2Src}
                    className="testimonial-image2"
                  />
                  <div className="testimonial-container15">
                    <strong className="thq-body-large">
                      {props.author2Name}
                    </strong>
                    <span className="thq-body-small">
                      {props.author2Position}
                    </span>
                  </div>
                </div>
                <span className="testimonial-text17 thq-body-small">
                  {props.review2}
                </span>
              </div>
            </div>
          </div>
          <div className="thq-animated-card-bg-2">
            <div className="thq-animated-card-bg-1">
              <div data-animated="true" className="thq-card testimonial-card3">
                <div className="testimonial-container16">
                  <img
                    alt={props.author3Alt}
                    src={props.author3Src}
                    className="testimonial-image3"
                  />
                  <div className="testimonial-container17">
                    <strong className="thq-body-large">
                      {props.author3Name}
                    </strong>
                    <span className="thq-body-small">
                      {props.author3Position}
                    </span>
                  </div>
                </div>
                <span className="testimonial-text20 thq-body-small">
                  {props.review3}
                </span>
              </div>
            </div>
          </div>
          <div className="thq-animated-card-bg-2">
            <div className="thq-animated-card-bg-1">
              <div data-animated="true" className="thq-card testimonial-card4">
                <div className="testimonial-container18">
                  <img
                    alt={props.author4Alt}
                    src={props.author4Src}
                    className="testimonial-image4"
                  />
                  <div className="testimonial-container19">
                    <strong className="thq-body-large">
                      {props.author4Name}
                    </strong>
                    <span className="thq-body-small">
                      {props.author4Position}
                    </span>
                  </div>
                </div>
                <span className="testimonial-text23 thq-body-small">
                  {props.review4}
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

Testimonial.defaultProps = {
  author3Alt: 'Image of Michael Brown',
  review2:
    'As a teacher, knowing the weather in advance helps me plan engaging outdoor lessons. This website is my go-to!',
  author4Alt: 'Image of Sarah Lee',
  author3Src:
    'https://images.unsplash.com/photo-1612999754243-3745bba6c302?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w5MTMyMXwwfDF8cmFuZG9tfHx8fHx8fHx8MTcyMzQ3MTI5OHw&ixlib=rb-4.0.3&q=80&w=1080',
  author3Name: 'Michael Brown',
  author2Name: 'Emily Johnson',
  author3Position: 'Photographer',
  heading1: 'Testimonials',
  author2Alt: 'Image of Emily Johnson',
  author1Alt: 'Image of John Smith',
  author4Position: 'Travel Blogger',
  author1Position: 'CEO, Company ABC',
  review4:
    'Traveling to different destinations requires accurate weather information. This website has been my travel companion.',
  author1Name: 'John Smith',
  author2Src:
    'https://images.unsplash.com/photo-1636041282690-8404f759538e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w5MTMyMXwwfDF8cmFuZG9tfHx8fHx8fHx8MTcyMzQ3MTI5OHw&ixlib=rb-4.0.3&q=80&w=1080',
  author4Name: 'Sarah Lee',
  author4Src:
    'https://images.unsplash.com/photo-1502452213786-a5bc0a67e963?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w5MTMyMXwwfDF8cmFuZG9tfHx8fHx8fHx8MTcyMzQ3MTI5OHw&ixlib=rb-4.0.3&q=80&w=1080',
  review1:
    'I rely on this weather forecast website daily for planning our outdoor events. It has never let me down!',
  content1:
    'Read what our users have to say about our accurate weather forecasts.',
  author1Src:
    'https://images.unsplash.com/photo-1525873765963-8931ab571545?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w5MTMyMXwwfDF8cmFuZG9tfHx8fHx8fHx8MTcyMzQ3MTI5N3w&ixlib=rb-4.0.3&q=80&w=1080',
  review3:
    'Weather plays a crucial role in my photography projects. Thanks to this website, I can schedule my shoots perfectly.',
  author2Position: 'Teacher',
}

Testimonial.propTypes = {
  author3Alt: PropTypes.string,
  review2: PropTypes.string,
  author4Alt: PropTypes.string,
  author3Src: PropTypes.string,
  author3Name: PropTypes.string,
  author2Name: PropTypes.string,
  author3Position: PropTypes.string,
  heading1: PropTypes.string,
  author2Alt: PropTypes.string,
  author1Alt: PropTypes.string,
  author4Position: PropTypes.string,
  author1Position: PropTypes.string,
  review4: PropTypes.string,
  author1Name: PropTypes.string,
  author2Src: PropTypes.string,
  author4Name: PropTypes.string,
  author4Src: PropTypes.string,
  review1: PropTypes.string,
  content1: PropTypes.string,
  author1Src: PropTypes.string,
  review3: PropTypes.string,
  author2Position: PropTypes.string,
}

export default Testimonial
