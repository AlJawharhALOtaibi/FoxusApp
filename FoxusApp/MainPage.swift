//
//  MainPage.swift
//  FoxusApp
//
//  Created by AlJawharh AlOtaibi on 21/05/1445 AH.
//

import SwiftUI
import CoreData


// Core Data Task Entity
class TaskEntity: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var taskName: String
    @NSManaged var taskTime: Date
    @NSManaged var taskPriority: String
    @NSManaged var status : Bool
}

enum Priority: String, CaseIterable {
    case low = "Low"
    case med = "     Medium"
    case high = "High"
    case extreme = "      Extreme"

    var color: Color {
        switch self {
        case .low:
            return Color.yellow
        case .med:
            return Color.orange
        case .high:
            return Color.red
        case .extreme:
            return Color(red: 0.6, green: 0.0, blue: 0.0)
        }
    }
    var Bordercolor: Color {
            switch self {
            case .low:
                return .yellow
            case .med:
                return .orange
            case .high:
                return .red
            case .extreme:
                return Color(red: 0.6, green: 0.0, blue: 0.0)
            }
        }

}


struct MainPage: View {
    @Environment(\.managedObjectContext) private var viewContext
    //    @FetchRequest(entity: TaskEntity.entity(), sortDescriptors: []) var tasks: FetchedResults<TaskEntity>
    //
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var tasks: FetchedResults<Task>
    @State private var isShowingSheet = false
    @State var selection: Int = 0
    var greeting: String {
        return greetingByTime()
    }
    var body: some View {
        
        
        NavigationView {
            VStack {
                
                //NewR
                Picker("Choose a side",selection: $selection ) {
                    Text("Upcoming").tag(0)
                    Text("Completed").tag(1)
                }.padding(0).padding()
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.top, 10)
                
                
                if(selection == 0){
                    List(tasks.filter{$0.status == false}) { task in
                        TaskCardView(task: task)
                        List(tasks.filter{$0.status ==  false}) { task in
                            
                        }
                    }
 
                        
                    }
                else{
                    List(tasks.filter{$0.status ==  false}) { task in
                        TaskCardView(task: task)
                    }
                    //NewR
                    
                    List {
                        ForEach(tasks, id: \.id) { task in
                            TaskCardView(task: task)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                    Button(action: {
                        isShowingSheet = true
                    }) {
                        Text("New Task")
                            .font(.headline)
                            .frame(width: 300, height: 50)
                            .foregroundColor(.white)
                            .background(Color.customColor)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                    }
                    .padding()
                    .sheet(isPresented: $isShowingSheet) {
                        TaskInputSheet(isPresented: $isShowingSheet, viewContext: viewContext)
                    }
                    .navigationTitle(greeting)

                }
                
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    
//                    NavigationLink(destination: CalenderView()) {
//                        VStack {
//                            
//                            Image("LOGO 1")
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                            
//                        }
//                    }
                }
            }
        }
        

    }
    
    func greetingByTime() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        
        if 5 <= currentHour && currentHour < 12 {
            return "Good morning,"
        } else if 12 <= currentHour && currentHour < 18 {
            return "Good afternoon,"
        } else {
            return "Good evening,"
        }
    }
}
struct TaskInputSheet: View {
    @Binding var isPresented: Bool
    @State private var taskName = ""
    @State private var taskTime = Date()
    @State private var selectedPriority: Priority = .low
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var tasks: FetchedResults<Task>
    //let viewContext: NSManagedObjectContext
    @Environment(\.managedObjectContext) private var viewContext

    init(isPresented: Binding<Bool>, viewContext: NSManagedObjectContext) {
        self._isPresented = isPresented
      //  self.viewContext = viewContext
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Task Name", text: $taskName)
                    DatePicker("Time", selection: $taskTime, displayedComponents: .hourAndMinute)
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(Priority.allCases.chunked(into: 2), id: \.self) { prioritiesRow in
                            HStack(spacing: 20) {
                                ForEach(prioritiesRow, id: \.self) { priority in
                                    Button(action: {
                                        selectedPriority = priority
                                    }) {
                                        HStack {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(selectedPriority == priority ? priority.color : Color.gray.opacity(0.3), lineWidth: 2)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .fill(selectedPriority == priority ? priority.color : Color.white)
                                                    )
                                                    .frame(width: 100, height: 50)
                                                    .overlay(
                                                        Circle()
                                                            .fill(priority.color)
                                                            .frame(width: 20, height: 20)
                                                            .offset(x: -35)
                                                    )
                                                    .overlay(
                                                        Text(priority.rawValue)
                                                            .foregroundColor(selectedPriority == priority ? .white : .black)
                                                    )
                                            }
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        if areFieldsValid() {
                          //  guard let priority = selectedPriority else { return }
                           let newTask =  Task(context: viewContext)
                           
                            newTask.name = taskName
                            newTask.time = taskTime
                            newTask.priority = selectedPriority.rawValue
                          //  newTask.status = taskStatus
//                            let newTask = Task(name: taskName, time: taskTime, priority: selectedPriority.rawValueselectedPriority, status: false) // Update Task initialization
                            //tasks.append(newTask)
                            
                            try? viewContext.save()
                            print("New Task: \(newTask)")
                            isPresented = false
                        } else {
                            showErrorAlert = true
                        }
                    }) {
                        Text("Save Task")
                            .font(.headline)
                            .frame(width: 300, height: 50)
                            .foregroundColor(.white)
                            .background(Color.customColor)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                    }
                }
            }
            .navigationBarTitle("New Task")
            .navigationBarItems(trailing: Button("Close") {
                isPresented = false
            })
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func areFieldsValid() -> Bool {
        if taskName.isEmpty || selectedPriority == nil {
            errorMessage = "Please fill in all the mandatory fields."
            return false
        }
        return true
    }
    
   
    
    private func saveTask() {
        let newTask = Task(context: viewContext)
       // newTask.id = UUID()
        newTask.name = taskName
        newTask.time = taskTime
        newTask.priority = selectedPriority.rawValue
        //  newTask.status = taskStatus

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Error saving new task: \(nsError), \(nsError.userInfo)")
        }
        
//        let newTask = TaskEntity(context: viewContext)
//        newTask.id = UUID()
//        newTask.taskName = taskName
//        newTask.taskTime = taskTime
//        newTask.taskPriority = selectedPriority.rawValue
//
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Error saving new task: \(nsError), \(nsError.userInfo)")
//        }
    }
}

struct OneSideBorderShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Add a path for the left side of the rect
        let leftSide = CGRect(x: rect.minX, y: rect.minY, width: 5, height: rect.height)
        path.addRect(leftSide)
    
        return path
    }
}
struct TaskCardView: View {
    
    let task: Task
//    @State private var isChecked: Bool = false
//    @State var priority: Priority
    //    var task: TaskEntity
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading) {
                    Text("Name: \(task.name ?? "")")
                    Text("Time: \(formattedTime(task.time!))")
                    Text("Priority: \(task.priority!)")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                
                //NewR
               // .overlay(OneSideBorderShape().stroke(task.priority.Bordercolor, lineWidth: 5))
                .cornerRadius(15)
                .padding([.horizontal, .bottom])
                
                //NewR
                Button(action: {
                    
                    task.status.toggle()
                    
                    
                }) {
                    
                    
                    
                    //   Text("DONE!")
                }
                //.buttonStyle(CheckboxStyle(isChecked: task.status))
            }
        }
        .swipeActions {
            Button(role:.destructive) {
                print("Delete")
            }label:{
                Label("Delete", systemImage: "trash.circle.fill")
            }
        }
        
        

    }
    func formattedTime(_ time: Date) -> String {
       let formatter = DateFormatter()
       formatter.dateStyle = .short
       formatter.timeStyle = .short
       return formatter.string(from: time)
   }
}
struct CheckboxStyle: ButtonStyle {
    @Binding var isChecked: Bool

    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .foregroundColor(isChecked ? .blue : .secondary)
            configuration.label
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

#Preview {
    MainPage()
}
