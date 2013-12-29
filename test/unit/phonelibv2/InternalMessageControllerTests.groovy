package phonelibv2



import org.junit.*
import grails.test.mixin.*

@TestFor(InternalMessageController)
@Mock(InternalMessage)
class InternalMessageControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/internalMessage/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.internalMessageInstanceList.size() == 0
        assert model.internalMessageInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.internalMessageInstance != null
    }

    void testSave() {
        controller.save()

        assert model.internalMessageInstance != null
        assert view == '/internalMessage/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/internalMessage/show/1'
        assert controller.flash.message != null
        assert InternalMessage.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/internalMessage/list'


        populateValidParams(params)
        def internalMessage = new InternalMessage(params)

        assert internalMessage.save() != null

        params.id = internalMessage.id

        def model = controller.show()

        assert model.internalMessageInstance == internalMessage
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/internalMessage/list'


        populateValidParams(params)
        def internalMessage = new InternalMessage(params)

        assert internalMessage.save() != null

        params.id = internalMessage.id

        def model = controller.edit()

        assert model.internalMessageInstance == internalMessage
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/internalMessage/list'

        response.reset()


        populateValidParams(params)
        def internalMessage = new InternalMessage(params)

        assert internalMessage.save() != null

        // test invalid parameters in update
        params.id = internalMessage.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/internalMessage/edit"
        assert model.internalMessageInstance != null

        internalMessage.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/internalMessage/show/$internalMessage.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        internalMessage.clearErrors()

        populateValidParams(params)
        params.id = internalMessage.id
        params.version = -1
        controller.update()

        assert view == "/internalMessage/edit"
        assert model.internalMessageInstance != null
        assert model.internalMessageInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/internalMessage/list'

        response.reset()

        populateValidParams(params)
        def internalMessage = new InternalMessage(params)

        assert internalMessage.save() != null
        assert InternalMessage.count() == 1

        params.id = internalMessage.id

        controller.delete()

        assert InternalMessage.count() == 0
        assert InternalMessage.get(internalMessage.id) == null
        assert response.redirectedUrl == '/internalMessage/list'
    }
}
