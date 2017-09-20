---
title: CBI-03 White Paper
layout: post
author: ross
permalink: /cbi-03-white-paper/
source-id: 1RS366BXaBxOrzVPhdKFhMpc-Ru1G_xqYhZHJ7WJhxrA
published: true
---
HDTRA1-17-S-0001 – CBI-03

# **High-Performance Stochastic Disease Outbreak Simulation for Mobile Platforms**

# EcoHealth Alliance, Noam Ross

* * *


# Technical Approach

### Background

Simulation of disease spread in populations is a key function of tools designed to provide decision support from either naturally occurring outbreaks or biological attacks. Stochastic simulation, where many simulations are run to account for uncertainty in conditions and unaccounted-for variation, is critical for forecasting the range of possible scenarios and their relative probabilities. However, stochastic simulation is computationally intensive because of the many repeat simulations that must be run for any set of conditions. For this reason, it has primarily been used in research contexts and using high-performance computing resources. Field-deployable platforms to enable real-time, stochastic disease model simulations currently do not exist because of these computational limitations.

### Objectives and Scope

EcoHealth proposes to develop **speedyssa.js **(Speedy Stochastic Simulation Algorithm JavaScript Library), a software library for high performance, stochastic disease simulation optimized for mobile devices. The proposed software will be designed for broad compatibility with disease simulation tools. It will be platform-independent and capable of integration into browser-based apps, requiring no installation but utilizing edge computing to run simulations on the user's device, removing dependence on remote server resources.

This library will be a stochastic analog to Lawrence Livermore National Laboratory's ODEPACK (NOTE:  https://computation.llnl.gov/casc/odepack/). ODEPACK is set of software libraries for solving ordinary differential equations used ubiquitously throughout software packages that perform deterministic simulations, ranging from both research and real-time applied applications in fields from biology to physics. **speedyssa.js **will similarly be able to be incorporated into a many programs for mobile stochastic simulation, particularly biological threat modeling. 

**speedyssa.js **will include (1) The implementation of a stochastic simulation optimized using high performance JavaScript (HPJ) technologies that allow simulation across mobile platforms, taking advantage of the full performance capabilities of mobile device CPUs and GPUs, (2) the development and implementation of algorithms to accelerate simulations at key bottlenecks via approximations with negligible loss in accuracy, (3) the creation of programmatic logic to select appropriate approximations automatically, freeing users from the need to understand the details of the algorithms in order to implement the highest-performance models, (4) a model-builder template (MBT) system, allowing users to quickly implement and deploy high-performance, mobile stochastic models with no more knowledge than required for creating traditional deterministic simulations, and (5) demonstration implementation of the JEM small-world SEIR disease model.

### Tasks and Methods

**Task 1 - Core high-performance simulation engine: **We will create an engine that can run on mobile devices at speeds faster than current desktop-based implementations. It will do so by fully exploiting mobile CPU and GPU hardware, yet be compatible across device types and operating systems via usage of a high-performance JavaScript (HPJ) framework. HPJ refers to a combination of new technologies:** emscripten.js** enables transcompilation of native machine code into **asm.js**, a subset of Javascript code that is highly optimizable across browsers and apps on all operating systems. **Web Assembly** is binary encoding of javascript code that accelerates the transfer and parsing of JavaScript by web browsers and other runtime engines. **Web Graphics Library (WebGL) **allows us to take advantage graphics processing units (GPUs) now ubiquitous in mobile devices to perform some calculations via massive parallelization. Recent versions of browsers and mobile operating systems are compatible with all these technologies, allowing the creation of truly portable high-performance software. Library development will include the creation of performance benchmark tests and demonstration simulations to test across a variety of mobile platforms.  It will also include thorough documentation of library functions and classes.

**Task 2 - Simulation acceleration algorithms: **While these HPJ technologies allow us to fully use the computational powers of modern mobile devices, we would still be limited by the computational capacity of mobile device hardware. We will to implement algorithms that can accelerate stochastic simulation by several orders of magnitude. Stochastic simulation primarily encounters computational bottlenecks under three conditions: when simulating large numbers of agents or units, when conditions are changing rapidly in time, and when individual agents or units vary greatly in behavior. We will implement two algorithmic approaches to overcome these bottlenecks: **Adaptive tau-leaping **[(Cao, Gillespie, and Petzold 2006)](https://paperpile.com/c/yVrscE/0H2Q)** **is an approach that approximates output by skipping over multiple steps at a time, and regularly checks the accuracy of results in order to modify the skip length and keep errors within small bounds. It rapidly speeds up simulations where the rate of change fluctuates rapidly in time, which is common in disease outbreak scenarios. **Rejection sampling algorithms **[(Allen and Dytham 2009)](https://paperpile.com/c/yVrscE/sXQb) accelerates the the case of individual-based simulations where simulation units are heterogenous. They do so by avoiding re-calculation of the behavior of every individual unit in the simulation when only a subset are responsible for changes in dynamics.  Implementation of these algorithms will include documentation of their applicability and uses across disease modeling tasks.

**Task 3: Algorithm-selection and tuning logic to ease model creation: **Stochastic simulations, as well as tau-leaping and rejection sampling, generally require a high level of computational knowledge. This is because because the appropriate algorithm or tuning parameters are highly context dependent. We will implement an application programming interface (API) that enables easier and more rapid model development by automatically selecting appropriate algorithms and tuning parameters based on the goal* *of the task, the outputs* *desired by the developer and the structure of the disease model being simulated. For instance, calculating the probability of an initial outbreak of disease, the average size of such outbreaks, or the range of final outcomes are all tasks optimized by different engine tuning parameters. **speedyssa.js** will select these parameters based on whether the user selects these outputs. Similarly, it will opt for tau-leaping vs rejection algorithm, and sub-forms of each, based on the whether the disease model structure includes components likely to generate the bottlenecks those algorithms best overcome.  Development of this API will include thorough documentation of the programmatic interface and demonstration code for developers to use in building their models.

**Task 4 - A ****model-builder for rapid model iteration and deployment****: speedyssa.js** will enable and improve a wide variety of disease-simulation applications, and be available as an open-source library for incorporation into other apps with maximum flexibility. The library will provide a template model-builder that will auto-generate code for a deployable model, which can then be integrated into a browser-based or native app. Users will be able to specify model structure in a small text file containing basic model structure, or in a high-level scripting language such as R. The generated program will have a graphical user interface through which users can run simulations, modify parameters, and generate visualizations of outputs. This will enable rapid interation, prototyping, and deployment of stochastic disease models. As part of the proposed effort, EHA will create and iterate upon the model-builder's graphical user interface to ensure ease of use and scalability to different modeling tasks and model structures.  This will include extensive walk-through documentation and examples for user self-training.

**Task 5 - Implementations the JEM small-world SEIR model: **The Joint Effects Model, a suite of software to simulate the consequences of chemical, biological, radiological and nuclear (CBRN) attacks, includes a disease simulation model. This model uses a "small-world" SEIR structure to approximate the much more complex agent-based EpiSim model. This approximation uses stochastic simulation, but even in its reduced form does not generate full estimates of the variation in possible outcomes due to computational limits. We will re-implement the small-world SEIR model using speedyssa.js as a performance benchmark and a demonstration of extended capabilities and richer on likelihood of outcome scenarios available from repeat stochastic simulation.

### Current and Required Capabilities

**Team: **The creation of **speedyssa.js** will require expertise in the use of high-performance computing, JavaScript development, mobile-device computing, stochastic simulation for disease outbreaks.  The experienced, multidisciplinary team comprising engineers, data scientists, emerging infectious disease specialists from EcoHealth alliance has all these capabilities.  The work will be led by Dr. Noam Ross (Senior Research Scientist) and Toph Allen (Director of Data Science), with input and project management by Dr. Peter Daszak (President) and Dr. Kevin Olival (Vice President for Research) who lead modeling and analytics for USAID-PREDICT and other large scale projects. Dr. Ross provides expertise in disease simulation and high-performance computing (NOTE:  Examples: Stochastic disease simulation of novel Coronavirus Outbreak: http://livescience.ecohealthalliance.org/predict/reports/2016-07-11-bat-guano-coronavirus.pdf,
fasterize: high-performance geospatial processing  https://github.com/ecohealthalliance/fasterize). Mr. Allen has led EHA's successful launch of EIDR, EIDR-Connect, Tater and other apps in use by the BSVE, including FLIRT, a stochastic simulator of disease spread via airline networks (NOTE:  Flight Risk Tracker https://flirt.eha.io/). An additional full-time software engineer will be hired to lead in the development of device optimization and implementation of WebGL/GPU technology.

**Facilities/Equipment:**** **EcoHealth Alliance (New York, USA) is a 45-year old scientific research NGO that specializes in multidisciplinary research and surveillance of the spread of zoonotic emerging diseases. EcoHealth Alliance is based in New York City with 10,000 square feet of office space. The scientific and technology staff (20 scientists and 6 engineers) and interns are supported by a core administrative staff of 11 people that are available to work on this project and are funded through core funds. Employees have around-the-clock remote access to servers (including a dedicated twenty-core Linux server and two Mac Pros).  In addition, our budget includes funds for the purchase of an array of mobile devices to test **speedyssa.js** performance across platforms. 

### Evidence of Teaming Arrangements:

All development of **speedyssa.js** will be performed in-house at EcoHealth Alliance.

### Technical and/or Scientific Challenges

**Performance optimization across devices: **While technologies such as WebAssembly and WebGL are broadly supported across mobile device operating systems, differences in mobile device hardware (memory, GPU and GPU size, etc.) result in different optimal performance configurations across devices.  To address this, **speedyssa.js** will include hardware detection so as to optimize for the local environment, and "fall-back" routines to ensure robust performance when some capabilities (such as parallel GPU computation) are not available.

**Maintaining compatibility in a rapidly evolving space: **High-performance JavaScript is a an evolving area of technology. While in widespread use, the introduction of new features and deprecation of old ones occurs rapidly.  We aim to ensure that **speedyssa.js** will keep pace with new development so as to retain top performance as well as backwards-compatibility so that apps using it can be easily maintained.  We will do so via modular design that allows routines within the library to be swapped out without breaking the programmatic or GUI interfaces users are accustomed to.

**API usability:  **Design of both the programmatic interface of the library and the GUI interface requires anticipating user needs and skill levels. The EHA team is experienced in iterative interface development through both its development of tools for the BSVE and its involvement in modular, community-based open source software development. (NOTE:  https://onboarding.ropensci.org/) We will beta-test** **the interfaces of our software library with a test community of modelers, user, and developers to ensure their ease of use.

# Project Narrative

**Our proposed technology addresses the topic area CBI-03** by providing a core engine for modeling and simulation of biological threats on mobile platforms.  High-performance simulation of these events will enable rapid simulation of outbreak threat scenarios, estimation of spread probabilities and size of population affected, and evaluation of possible interventions to provide decision support for response and mitigation. **speedyssa.js **provides a technology platform on top of which all these applications may be developed, and by which mobile tools can be easily deployed and freed from reliance on central, server based simulators. It will enable the movement of compute-intensive simulation tools to more flexible, mobile platforms.  Examples include the Joint Effects Model and EHA's Modular Disease Simulator (see our proposal under CBI-07, Modular Disease Simulator, PI Toph Allen).

**Our proposal address DoD goals of mitigating, responding, and recovering from CBRN threats, specifically biological attacks or disease outbreaks the arena.  **By providing a platform for mobile disease simulation, we will enable a generation of tools by which mobile users will be able to quantify the consequences of biological threats, forecast possible outcomes, and evaluate strategic or tactical responses with richer information. In particular, enabling mobile stochastic simulation will provide the ability to better quantify risk and uncertainty associated with biological threats. This field-deployable solution will improve the readiness and response time of DoD analysts, warfighters, and other personnel based in remote locations.

## speedyssa.js will be made available to all DoD users as a public, open-source software library.  It will use no proprietary dependencies or hosting, ensuring it can be integrated into any tool created by DoD end-users, developers, or contractors.  Documentation and examples will be built into the software library to ensure ease-of use.

The technology described in this proposal is currently at **TRL 3**. We anticipate reaching **TRL 6** by the end of the proposed period.

# Proposed Schedule

We propose a two-year schedule for the development of **speedyssa.js**. EcoHealth Alliance has the necessary combination of engineering and scientific domain expertise to complete this project successfully within the proposed schedule. The EHA team has a proven track record of delivering DTRA tasks similar to those proposed on time and above expectation.  HPJ technologies are mature and acceleration algorithms are well-established scientifically; we anticipate no major challenges in their integration and implementation.  

# Estimated Costs and Cost Breakdown

We anticipate this project to be approximately $666,700 for a two-year period. Cost estimates were derived from current labor rates of all technical and research staff, rough order of magnitude estimates of travel costs (including planned meetings with DTRA and other partners, and conferences to present research), plus other direct costs costs based on past projects. Direct costs include estimates for purchase of an array of test mobile devices, cloud processing and application services, domain registrar, code hosting, reference materials, software licensing, publication fees, meeting costs. Fringe and indirect cost rates are based on federally approved rates for 2017 (fringe: 31.3%; indirect: 32.0%), but are subject to change before the project start date.

<table>
  <tr>
    <td></td>
    <td>Year 1</td>
    <td>Year 2</td>
  </tr>
  <tr>
    <td>Total Direct Labor</td>
    <td>$173,269</td>
    <td>$198,304</td>
  </tr>
  <tr>
    <td>Fringe Rate</td>
    <td>31.30%</td>
    <td>31.30%</td>
  </tr>
  <tr>
    <td>Total Labor</td>
    <td>$227,502</td>
    <td>$260,373</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Travel</td>
    <td>$2,000</td>
    <td>$2,000</td>
  </tr>
  <tr>
    <td>Other Direct Costs</td>
    <td>$8,000</td>
    <td>$5,000</td>
  </tr>
  <tr>
    <td>Total Direct Costs</td>
    <td>$237,502</td>
    <td>$267,373</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Indirect Rate</td>
    <td>32.00%</td>
    <td>32.00%</td>
  </tr>
  <tr>
    <td>Total Costs</td>
    <td>$313,503</td>
    <td>$352,933</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Total Proposal Cost</td>
    <td></td>
    <td>$666,436</td>
  </tr>
</table>


# References

[Allen, George Edward, and Calvin Dytham. 2009. "An Efficient Method for Stochastic Simulation of Biological Populations in Continuous Time." ](http://paperpile.com/b/yVrscE/sXQb)*[Bio System*s](http://paperpile.com/b/yVrscE/sXQb)[ 98 (1): 37–42. doi:](http://paperpile.com/b/yVrscE/sXQb)[10.1016/j.biosystems.2009.07.003](http://dx.doi.org/10.1016/j.biosystems.2009.07.003)[.](http://paperpile.com/b/yVrscE/sXQb)

[Cao, Yang, Daniel T. Gillespie, and Linda R. Petzold. 2006. "Efficient Step Size Selection for the Tau-Leaping Simulation Method." ](http://paperpile.com/b/yVrscE/0H2Q)*[The Journal of Chemical Physic*s](http://paperpile.com/b/yVrscE/0H2Q)[ 124 (4): 044109. doi:](http://paperpile.com/b/yVrscE/0H2Q)[10.1063/1.2159468](http://dx.doi.org/10.1063/1.2159468)

